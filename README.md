# lhci-cron-client

---
Lighthouse website monitoring by Cron.

Original Lighthouse-CI solution is targeted to git-based CI setup.
This container allows you to monitor your websites without CI and git,
just pass several env variables, and it will send all data to lhci-server.

### Running the image

````
docker run \
    -d \
    -e CONFIG_PATH="/data/lighthouserc.json" \
    -e CRON="0 * * * *" \
    -v /path/to/config/folder:/data \
    ghcr.io/denidoman/lhci-cron-client:main
````

Environment variables list:

| Name                               | Default                                        | Description                                                                                                                                                                                                                                  |
|------------------------------------|------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| CONFIG_PATH                        | \<required\>                                   | Path to your [configuration](https://github.com/GoogleChrome/lighthouse-ci/blob/main/docs/configuration.md) file. There is no default one, so you need to create it in a mounted directory or volume and set this Env variable with the path |
| CRON                               | @daily                                         | Cron schedule, use default [crontab](https://crontab.guru/) format                                                                                                                                                                           |
| LHCI_BUILD_CONTEXT__CURRENT_HASH   | (timestamp hex)                                | lhci requires git attributes, so I put these placeholders. You can override it using these Env variables. For example, you can put server location name into branch field for easier results filtering                                       |
| LHCI_BUILD_CONTEXT__CURRENT_BRANCH | main                                           | same                                                                                                                                                                                                                                         |
| LHCI_BUILD_CONTEXT__COMMIT_MESSAGE | CRON_RUN                                       | same                                                                                                                                                                                                                                         |
| LHCI_BUILD_CONTEXT__COMMIT_TIME    | (timestamp)                                    | same                                                                                                                                                                                                                                         |
| LHCI_BUILD_CONTEXT__AUTHOR         | CRON_JOB                                       | same                                                                                                                                                                                                                                         |
| LHCI_BUILD_CONTEXT__AVATAR_URL     | [picsum.photos/200](https://picsum.photos/200) | same                                                                                                                                                                                                                                         |

### Known issues

> ❗File paths inside your configuration file must be relative from `/home/lhci/reports/` directory. For example,
> if you want to use puppeteer script and provide `puppeteerScript` option, and your script file placed
> in `data/script.js`, then `puppeteerScript` value should be `../../../data/script.js`. In the same time, it doesn't affect
> CONFIG_PATH variable, so if your config is in /data/ dir - then just pass `/data/lighthouserc.json` value.

> ❗Lighthouse process running as root. You are free to raise an issue about it, but better to raise a PR :)

### License MIT