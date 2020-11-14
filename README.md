# FLORAL SCYTHE

Pluralsight Course Batch Downloader.

## Prerequisite

1. Enroll and Pay for your [Pluralsight Account](https://www.pluralsight.com/pricing/free-trial).
2. [youtube-dl](https://youtube-dl.org/)
3. [jq](https://stedolan.github.io/jq/)

## Installation

Clone this repo or copy the contents of [`floralscythe.sh`](./floralscythe.sh) somewhere in your machine.

## Usage

1. Create a [json file with this format](./download-list.json):

    * `courses.url` states the URL of the Pluralsight course
    * `courses.start` states in what video do you want to start

1. Save your Pluralsight Password in your `~/.pscred` file.
    * I just don't like passwords dangling around beside a shell command
    * Or if you like flaunting your password in a terminal, just run:

    ``` bash
    export PLURALPASS="Y0uRS3cur3DP@ssw0rd69"
    ```

1. Run the Shell file

    * `username` your Pluralsight username
    * `sleep` interval needed to prevent throttling
    * `dowloadfile` path of the [JSON File](./download-list.json)

    ``` bash
    sh floralscythe.sh [username] [sleep] [downloadfile]
    ```

    ``` bash
    sh floralscythe.sh pend0ng 100 ./download-list.json
    ```

## Why I Built it

I created this batch downloader for educational purposes and to help me learn while I am on a rural vacation and I do not have internet.

I do not promote downloading Pluralsight videos.

## NOTE

Pluralsight Terms of Use does not allow downloading / storing of the video.

Quoting from www.pluralsight.com/terms

> Proprietary Materials may only be accessed through the Site, and not by or from any other site or means. The applicable License granted you by these Terms of Use is a right of access through the Site only, and does not grant to you any right to download or store any Proprietary Materials in any medium.
