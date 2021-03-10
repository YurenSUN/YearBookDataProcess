// copy to the chrome console
// the year book that I download at:
// chinese statistical yearbook (english version of website)
// accessible during COVID19 till 2021-03-31 from Wisc vpn and account
// https://cdi-cnki-net.ezproxy.library.wisc.edu/Titles/SingleNJ?NJCode=N2019070152

// code below might not work well when switching pages
let numPages = document.getElementsByClassName("number-of-pages")[0].innerHTML
for(let j = 0; j < numPages; j ++){
    let list = document.getElementsByClassName("indiexc") 
    // the div with <a> elt inside for excel download
    for(let i = 0; i < list.length; i ++){
        let cur = list[i];
        cur.children[0].click();
    }
    // go to next page
    document.getElementsByClassName("next")[0].click();
}

// might be better to do this for each page
let list = document.getElementsByClassName("indiexc")
for(let i = 0; i < list.length; i ++){
    let cur = list[i];
    cur.children[0].click();
}
document.getElementsByClassName("next")[0].click();