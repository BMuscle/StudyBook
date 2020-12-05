window.userImageLoad = function(e) {
  let image = document.getElementById('user_image_upload');
  const files = e.target.files;	//ファイルを全部取得
  if(files.length > 0){		//1つ以上存在すればOK
    const file = files[0];	//最初の物を取得
    const reader = new FileReader();	//ファイルを読み込むためのもの
    reader.onload = (e) => {	//ファイルがロードされたら動き出す。（そこまで停止している）
      let imageData = e.target.result;	//:src = に値が格納されるbase64形式で画像が格納される
      image.style.backgroundImage = `url(${imageData})`;
      console.log('aaa');
    };
    reader.readAsDataURL(file);
  }
};

window.toggleUserList = function() {
  let userPullList = document.getElementById('navbar_user_pull_list');
  console.log(userPullList.dataset.open);
  if(userPullList.dataset.open == 'true') {
    // 閉じる classをnone
    userPullList.style.display = 'none';
    userPullList.dataset.open = 'false';
  } else {
    // 開く classをblock
    userPullList.style.display = 'block';
    userPullList.dataset.open = 'true';
    console.log(userPullList.dataset.open);
  }
};