// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

module.exports = {
  defaultBrowser: "Google Chrome",
  options: {
    // Hide the finicky icon from the top bar
    // hideIcon: true
    checkForUpdate: true,
    logRequests: true
  },
  handlers: [
  { // Open Zoom URL directly in Zoom
      match: [
        "zoom.us/*",
        finicky.matchDomains(/.*\zoom.us/),
        /zoom.us\/j\//,
      ],
      url: ({urlString}) => {
        let new_url = urlString.replace("https://www.google.com/url?q=", "").split("&source=gmail")[0].replace("%3D", "=");
        finicky.log("1. Rewritten to -> " + new_url);
        return new_url;  // if we open from Google services we start with google.com/url?q=
      },
      browser: "us.zoom.xos"
  },
  { // Open youtube from Ferdi in Private Chrome
    match: ({ opener, url, urlString }) => {
      return urlString.includes("youtube");
    },
    browser: ({urlString}) => {
      // return {
      //   name: "Google Chrome",
      //   args: ["--incognito", urlString]
      // }
      return {
        name: "DuckDuckGo"
      }
    }
  },
  { // Open everything else from Ferdi in incognito unless Command is pressed
    match: ({ opener, url, urlString }) => {
      return opener.path.includes("Ferdi.app") || opener.path.includes("Ferdium.app") || opener.path.includes("Signal.app") || opener.path.includes("Rambox.app");
    },
    url: ({url, urlString}) => {
      finicky.log("URL -> " + url);
      finicky.log("URLString -> " + urlString);

      let new_url = urlString.replace("https://www.google.com/url?q=", "").split("&source=gmail")[0].replace("%3D", "=");
      finicky.log("2. Rewritten to -> " + new_url);
      return new_url;  // if we open from Google services we start with google.com/url?q=
    },
    browser: ({urlString}) => finicky.getKeys().command ? {name: "Google Chrome", args: [urlString] } : {
      name: "Google Chrome",
      args: ["--incognito", urlString]
    }
  },
]
/*
  handlers: [
    {
      // Open google.com and *.google.com urls in Google Chrome
      match: [
        "google.com*", // match google.com urls
        finicky.matchDomains(/.*\.google.com/) // use helper function to match on domain only
      ],
      browser: "Google Chrome"
    }
  ]
*/
}
