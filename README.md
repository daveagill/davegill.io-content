Install HUGO

    brew install hugo

Clone this content repo

    git clone git@github.com:daveagill/davegill.io-content.git
    cd davegill.io-content

Pull the theme and the site hosting repos

    git submodule update --init --recursive

Update to the submodule commit link to latest version of the theme (if not already)

    git submodule update --remote

Start the hugo server to preview changes

    hugo server

Build & publish the update

    ./deploy.sh