class StudyLog < Influxdb::Base
  STATUS_CODE_OF_NO_CONTENT = "204".freeze

  # logsは、note_idとword_countのハッシュの配列
  def write_study_log(logs = [])
    return unless call_write_api(logs)

    true
  rescue StandardError
    false
  end

  # 当月を含む過去12ヶ月間(12ヶ月前は含む)
  def user_monthly_study_length
    result = get_logs_by_range('1mo', 1.years)
    result.present? ? result : 13.times.map { 0 }
  end

  private

  def call_write_api(logs)
    write_api(data: import_study_data(logs))&.code == STATUS_CODE_OF_NO_CONTENT
  end

  def import_study_data(logs)
    [].tap do |arr|
      logs.each do |log|
        log[:date_at] ||= Time.now.utc
        log[:word_count] ||= 0
        arr << InfluxDB2::Point.new(name: @client.user_id)
                               .add_tag('note_id', log[:note_id])
                               .add_field('word_count', log[:word_count])
                               .time(log[:date_at], InfluxDB2::WritePrecision::NANOSECOND)
      end
    end
  end

  def get_logs_by_range(every, ago_time)
    stop_time = Time.zone.now
    start_time = stop_time.ago(ago_time)
    query = "from(bucket: \"#{@client.bucket}\")
      |> range(start: #{start_time.iso8601}, stop: #{stop_time.iso8601})
      |> filter(fn: (r) =>
          r._measurement == \"#{@client.user_id}\")
      |> group(columns: [\"_measurement\"])
      |> window(every: #{every}, createEmpty: true)
      |> sum()"
    @client.query_api.query(query: query).map { |section| section[1].records[0].value || 0 }
  end
end
