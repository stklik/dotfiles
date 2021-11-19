// Use https://finicky-kickstart.now.sh to generate basic configuration
// Learn more about configuration options: https://github.com/johnste/finicky/wiki/Configuration

module.exports = {
  defaultBrowser: "Google Chrome",
  options: {
    // Hide the finicky icon from the top bar
    // hideIcon: true
    checkForUpdate: true,
    // logRequests: true
  },
  handlers: [
  { // Open Zoom URL directly in Zoom
      match: [
        "zoom.us/*",
        finicky.matchDomains(/.*\zoom.us/),
        /zoom.us\/j\//,
      ],
      browser: "us.zoom.xos"
  },
  { // Open everything else from Ferdi in TOR unless Command is pressed
    match: ({ opener, url, urlString }) => {
      return opener.path.includes("Ferdi.app");
    },
    browser: ({}) => finicky.getKeys().command ? "Google Chrome" : "/Applications/Tor Browser.app"
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
