var counthtml = document.getElementById("count")

let count = 0

const setData = {
    value : "1"
}

function updateCount(){
    
}

// function addCount(){
//     fetch("https://jwow2heow8.execute-api.us-east-1.amazonaws.com/dev", {
//         method: "POST",
//         body: JSON.stringify(setData),
//         headers: {
//             "Content-type": "application/json; charset=UTF-8"
//           },
//           mode: "no-cors"  
//     })
//     .then(res => console.log(res))
//     fetch("https://a3eyxf14g7.execute-api.us-east-1.amazonaws.com/default/readFromTable")
//         .then((res) => {
//             res.json().then(data => {
//                 count = data[0].view_Count
//                 counthtml.innerText = count
//             })
//         })
//     // .then(json => console.log(json))
// }

function addCount(){
    fetch("https://mxlsbrzthk.execute-api.us-east-1.amazonaws.com/dev/views", {
        method : "POST",
        body: JSON.stringify(setData),
    })
    .then(response => response.json())
    .then(data => {
        count = data
     counthtml.innerText = count
    })
}

addCount()
updateCount()