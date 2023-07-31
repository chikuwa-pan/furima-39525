const priceInput = document.getElementById("item-price");
priceInput.addEventListener("keyup", () => {
  const price = parseInt(priceInput.value); // 入力された金額を整数に変換

  // 価格が有効な数値であれば計算結果を表示する
  if (!isNaN(price)) {
    const taxPrice = document.getElementById("add-tax-price");
    const calculator = Math.floor(price * 0.1);
    taxPrice.innerHTML = calculator;

    const profit = price - calculator;
    const profitElement = document.getElementById("profit");
    profitElement.innerHTML = profit;
  } else {
    // 価格が無効な数値（NaN）の場合は空にする
    const taxPrice = document.getElementById("add-tax-price");
    taxPrice.innerHTML = "";

    const profitElement = document.getElementById("profit");
    profitElement.innerHTML = "";
  }
});

