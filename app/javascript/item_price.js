const priceInput = document.getElementById("item-price");
priceInput.addEventListener("keyup", () => {
  const price = parseInt(priceInput.value); // 入力された金額を整数に変換
  const taxPrice = document.getElementById("add-tax-price"); // 変数taxPriceにtax-priceをいれる
  const calculator = Math.floor(price * 0.1); // 入力された金額の10%を計算（小数点以下は切り捨て）
  taxPrice.innerHTML = calculator;

  const profit = price - calculator;
  const profitElement = document.getElementById("profit");
  profitElement.innerHTML = profit;
});