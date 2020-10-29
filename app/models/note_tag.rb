class NoteTag < ApplicationRecord
    belongs_to :notes
    belongs_to :tags

    validates :note_id, presence: true, uniqueness: {scope: :tag_id}
    validates :tag_id, presence: true, uniqueness: {scope: :note_id}
end
