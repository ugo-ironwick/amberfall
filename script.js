console.log("Bonjour Ironwick")
let ambre = 0;
function collecter() {
    ambre = ambre + 1;
    document.getElementById("compteur").textContent = "Ambre : " + ambre;
}
document.getElementById("btn-collecter").addEventListener("click", collecter);