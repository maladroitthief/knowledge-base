(function() {
    function showResults(results, store) {
        var searchResults = document.getElementById('search-results');

        if (results.length) {
            var appendString = '';

            for (var i = 0; i < results.length; i++) {
                var item = store[results[i].ref];
                appendString += '<li><a href="' + item.url + '">' + item.title + '</a>';
                appendString += '<p>' + item.content.substring(0, 250) + '...</p></li>';
            }

            searchResults.innerHTML = appendString;
        } else {
            searchResults.innerHTML = '<li>No results found</li>';
        }
    }

    function getQuery(variable) {
        var query = window.location.search.substring(1);
        var vars = query.split('&');

        for (var i = 0; i < vars.length; i++) {
            var pair = vars[i].split('=');

            if (pair[0] === variable) {
                return decodeURIComponent(pair[1].replace(/\+/g, '%20'));
            }
        }
    }

    var searchTerm = getQuery('query');

    if (searchTerm) {
        document.getElementById('search-box').setAttribute("value", searchTerm);

        // The title field is given more weight with the "boost" parameter
        var idx = lunr(function() {
            this.field('id');
            this.field('title', { boost: 10 });
            this.field('author');
            this.field('category');
            this.field('content');

            // FIXME: remove the window global variable
            for (var key in window.store) { // Add the JSON we generated from the site content to Lunr.js.
                this.add({
                    'id': key,
                    'title': window.store[key].title,
                    'author': window.store[key].author,
                    'category': window.store[key].category,
                    'content': window.store[key].content
                });
            }
        });
        console.log(idx);

        var results = idx.search(searchTerm);
        showResults(results, window.store);
    }
})();
