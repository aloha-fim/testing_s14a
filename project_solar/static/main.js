// static/main.js

console.log("Sanity check!");

// Get Stripe publishable key
fetch("/listings/config")
.then((result) => { return result.json(); })
.then((data) => {
  // Initialize Stripe.js
  const stripe = Stripe(data.publicKey);
  
  // new
  // Event handler
 document.querySelector("#submitBtn").addEventListener("click", () => {
    // Get Checkout Session ID 
    //if (el) {
    //  el.addEventListener('click', swapper, false);
    //} 
    const listing_id = document.getElementById("submitBtn").value;
    fetch(`/listings/create-checkout-session/${listing_id}`)
    .then((result) => { return result.json(); })
    .then((data) => {
      console.log(data);
      // Redirect to Stripe Checkout
      return stripe.redirectToCheckout({sessionId: data.sessionId})
    })
    .then((res) => {
      console.log(res);
    });
  });
});