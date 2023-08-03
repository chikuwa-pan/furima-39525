function calculateProfit () {
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
      const price = parseInt(itemPrice.value); // 入力した金額を取得
        const calculator = Math.floor(price * 0.1); // 手数料計算
        const addTaxPrice = document.getElementById("add-tax-price");
        const profit = document.getElementById("profit");
    if (!isNaN(price)) {
        addTaxPrice.innerHTML = calculator; // 手数料表示
        const profitElement = price - calculator; // 利益計算
        profit.innerHTML = profitElement; // 利益表示
    } else {
        // 価格が無効な数値（NaN）の場合は空にする
        addTaxPrice.innerHTML = "";
        profit.innerHTML = "";
    }
  });
};
window.addEventListener('turbo:load', calculateProfit);