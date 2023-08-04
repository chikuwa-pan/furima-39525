const pay = () => {
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
  const elements = payjp.elements();
  const form = document.getElementById('charge-form')

  const numberElement = elements.create('cardNumber'); // カード番号いれる箱
    const expiryElement = elements.create('cardExpiry'); // 有効期限いれる箱
    const cvcElement = elements.create('cardCvc'); // セキュリティコード入れる箱
    numberElement.mount('#number-form'); //カード番号のID
    expiryElement.mount('#expiry-form'); //有効期限のID
    cvcElement.mount('#cvc-form'); //セキュリティコードのID

  form.addEventListener("submit", (e) => { // 送信ボタンでイベント発生
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById("charge-form").submit();
    });
    e.preventDefault();
  });
};

window.addEventListener("load", pay);