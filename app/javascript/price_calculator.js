function price_calculate (){
  const priceInput = document.getElementById("item-price")
  priceInput.addEventListener("input",() => {
    const inputVal = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const addTaxVal = Math.floor(inputVal*0.1);
    addTaxDom.innerHTML = addTaxVal;
    const addProDom = document.getElementById("profit");
    const addProVal = inputVal - addTaxVal;
    addProDom.innerHTML = addProVal;
  });
};

window.addEventListener('load',price_calculate);