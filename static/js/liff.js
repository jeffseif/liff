// Functions

var WORDS;
var MAX_MATCHES = 5;

function onLoad() {
    LIFF = JSON.parse(LIFF);
    WORDS = new Set(Object.keys(LIFF));

    document.getElementById('lookup').select();

    updateResults();
};

function lookupMatches(lookup) {

    var matchSet = new Set();

    if (lookup.length > 0) {

        // Direct match
        if (WORDS.has(lookup)) matchSet.add(lookup);

        for (var word in LIFF) {

            // Word subset
            if (word.search(lookup) >= 0) matchSet.add(word);

            // Definition subset
            defn = LIFF[word][1];
            if (defn.toLowerCase().search(lookup) >= 0) matchSet.add(word);

        };
    };

    var matchArray = Array.from(matchSet);
    matchArray.sort();
    return matchArray.slice(0, MAX_MATCHES);

};

function matchesToHTML(matches) {
    var html = '';
    for (index in matches) {
        word = matches[index];
        part = LIFF[word][0];
        defn = LIFF[word][1];

        html += (
                "<div class='result'>"
            +   "<span class='word'>"
            +   word
            +   "</span> "
            +   "<span class='part'>"
            +   part
            +   "</span>"
            +   " "
            +   "<span class='defn'>"
            +   defn
            +   "</span>"
            +   "</div>"
        );
    };
    return html;
};

function updateResults() {

    lookup = document.getElementById('lookup').value.toLowerCase();

    matches = lookupMatches(lookup);

    document.getElementById('results').innerHTML = matchesToHTML(matches);

};

// Main

window.onload = onLoad;
