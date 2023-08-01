const pay = () => {
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form'); //カード番号のID
  expiryElement.mount('#expiry-form'); //有効期限のID
  cvcElement.mount('#cvc-form'); //セキュリティコードのID
  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
    payjp.createToken(numberElement).then(function (response) { //戻り値としてカード情報のトークンを取得するやつ
      if (response.error) {
      } else {
        const token = response.id; // PAY.JPのサーバーに送ったカード情報をもとに、PAY.JPが発行したトークンをresponse.idから取得
          const renderDom = document.getElementById("charge-form"); // 購入ページのFORM取得
          const tokenObj = `<input value=${token} name='token' type="hidden">`; // フォームに埋め込むトークンを、HTMLの<input>要素として作成。トークンをvalue属性にセットし、name属性には'token'という名前を設定。サーバーサイドでトークンを取得し、PAY.JPとのやり取りができるようになーる。
          renderDom.insertAdjacentHTML("beforeend", tokenObj); // renderDomで取得したフォーム要素の末尾に、先ほど作成した<input>要素を挿入しています。これにより、トークンがフォームに埋め込まれます。
      }
      numberElement.clear(); //カード情報を削除
      expiryElement.clear(); //カード情報を削除
      cvcElement.clear(); //カード情報を削除
      document.getElementById("charge-form").submit(); //サーバーに送信
    });
    e.preventDefault();
  });
};

window.addEventListener("load", pay);
