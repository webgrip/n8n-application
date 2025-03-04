## [1.4.4](https://github.com/webgrip/n8n-application/compare/1.4.3...1.4.4) (2025-03-05)


### Bug Fixes

* **docker:** Fix permissions ([2bca530](https://github.com/webgrip/n8n-application/commit/2bca530d73f04ad5d36ded75eb41f2146ccf3d9d))

## [1.4.3](https://github.com/webgrip/n8n-application/compare/1.4.2...1.4.3) (2025-03-05)


### Bug Fixes

* **docker:** Fix permissions ([9c400e4](https://github.com/webgrip/n8n-application/commit/9c400e43a44b66280be0b5f71fee957c61f61004))

## [1.4.2](https://github.com/webgrip/n8n-application/compare/1.4.1...1.4.2) (2025-03-05)


### Bug Fixes

* **import:** Put workflows and credentials in a different directory again, just like I did for the the docker-entrypoint problem ([73997f5](https://github.com/webgrip/n8n-application/commit/73997f55c8eae534033920522104fdc086e0ce08))

## [1.4.1](https://github.com/webgrip/n8n-application/compare/1.4.0...1.4.1) (2025-03-05)


### Bug Fixes

* **postgres:** Actually use postgresql in n8n ([a31bd5b](https://github.com/webgrip/n8n-application/commit/a31bd5b8d47dbbafaf5749d19b8a79302b687664))
* **postgres:** Forego service monitor ([4421163](https://github.com/webgrip/n8n-application/commit/4421163c4e751e1cd353975ce54edf4f956ffe06))
* **postgres:** Set the postgres username to the auth itself ([bc89b6e](https://github.com/webgrip/n8n-application/commit/bc89b6e6c24fd6d4595348221be0bb7c84f9dd84))

# [1.4.0](https://github.com/webgrip/n8n-application/compare/1.3.0...1.4.0) (2025-03-05)


### Bug Fixes

* **workflows:** Don't trigger new application release when postgresql ops is changed ([84542db](https://github.com/webgrip/n8n-application/commit/84542dbfc618396d60ba86123522ad72fb82c906))


### Features

* **helm:** PostgreSQL replication -> standalone ([dd64a0c](https://github.com/webgrip/n8n-application/commit/dd64a0c52a3a89bbcf83f4ad4a6bf6364d8d3e10))

# [1.3.0](https://github.com/webgrip/n8n-application/compare/1.2.5...1.3.0) (2025-03-05)


### Features

* **helm:** Added postgresql to helm ([500a9d1](https://github.com/webgrip/n8n-application/commit/500a9d1720dc6979ee97d07741e421c4b410f021))

## [1.2.5](https://github.com/webgrip/n8n-application/compare/1.2.4...1.2.5) (2025-03-05)


### Bug Fixes

* Add manual deploy action ([bf1cf6e](https://github.com/webgrip/n8n-application/commit/bf1cf6e17452c1070837fa21c1375d51e59ed092))
* **docker:** Put the scripts into a directory NOT in /home/node/.n8n/*, because that is likely overwritten by the kubernetes pod with a volume mount ([fa561f7](https://github.com/webgrip/n8n-application/commit/fa561f79c72fb2010ea78b34f1d3a3d5252219aa))

## [1.2.4](https://github.com/webgrip/n8n-application/compare/1.2.3...1.2.4) (2025-03-05)


### Bug Fixes

* need release so I can get the output ([e039d66](https://github.com/webgrip/n8n-application/commit/e039d66b7588d2408d3a9c528e9c5c5a3bde62a6))

## [1.2.3](https://github.com/webgrip/n8n-application/compare/1.2.2...1.2.3) (2025-03-05)


### Bug Fixes

* Only build docker image when a new release was made ([bdd53a7](https://github.com/webgrip/n8n-application/commit/bdd53a7fa7d915666f9e4ae28d40f3d3dbd2d727))
* Only build docker image when a new release was made ([65dcd73](https://github.com/webgrip/n8n-application/commit/65dcd73349b3a03079db183c85f32490550eb40c))

## [1.2.2](https://github.com/webgrip/n8n-application/compare/1.2.1...1.2.2) (2025-03-05)


### Bug Fixes

* Redeploy with new workflow ([408d177](https://github.com/webgrip/n8n-application/commit/408d17742912fe8fc3ba312bb62630ecd072a637))

## [1.2.1](https://github.com/webgrip/n8n-application/compare/1.2.0...1.2.1) (2025-03-05)


### Bug Fixes

* Added some env stuff, and update so that we deploy a specific tag ([9935c53](https://github.com/webgrip/n8n-application/commit/9935c5375449843e4fbca37a67d54524c4aa01ef))

# [1.2.0](https://github.com/webgrip/n8n-application/compare/1.1.0...1.2.0) (2025-03-05)


### Features

* rename step to release ([c1ac939](https://github.com/webgrip/n8n-application/commit/c1ac939ee04252dbafe75271dbcde45b410b7b46))

# [1.1.0](https://github.com/webgrip/n8n-application/compare/1.0.5...1.1.0) (2025-03-05)


### Features

* import credentials and workflows based on environment variables (secrets) ([024999c](https://github.com/webgrip/n8n-application/commit/024999caad1e8aedacdf7a60d03ae6f30a077f02))

## [1.0.5](https://github.com/webgrip/n8n-application/compare/1.0.4...1.0.5) (2025-03-05)


### Bug Fixes

* **application:** Set WEBHOOK_URL env instead of N8N_WEBHOOK_URL ([f1d9d85](https://github.com/webgrip/n8n-application/commit/f1d9d85c3fc0b562a071d7753e9283f076732811))

## [1.0.4](https://github.com/webgrip/n8n-application/compare/1.0.3...1.0.4) (2025-03-04)


### Bug Fixes

* **certificate:** Don't redirect right away ([618a53a](https://github.com/webgrip/n8n-application/commit/618a53a94c573e318632ad5de0f1df74feaeeaf9))

## [1.0.3](https://github.com/webgrip/n8n-application/compare/1.0.2...1.0.3) (2025-03-04)


### Bug Fixes

* **certificate:** Move to the nginx ClusterIssuer ([a87db4e](https://github.com/webgrip/n8n-application/commit/a87db4e572fd06aa910865257ceae26f888d168d))

## [1.0.2](https://github.com/webgrip/n8n-application/compare/1.0.1...1.0.2) (2025-03-04)


### Bug Fixes

* **helm:** Fix The TLS should be an array ([5669a8e](https://github.com/webgrip/n8n-application/commit/5669a8e487c4f191d48414dd71bd9840c4729962))
* **workflows:** Move the release to before the build ([e4e802a](https://github.com/webgrip/n8n-application/commit/e4e802ae1b24cb688f18b0b70b51dbfc3ed9ca92))

## [1.0.1](https://github.com/webgrip/n8n-application/compare/1.0.0...1.0.1) (2025-03-04)


### Bug Fixes

* **vanity:** Make names look nicer in actions ([af99ca1](https://github.com/webgrip/n8n-application/commit/af99ca10beb261a21a70ea8e34e225cb106f967d))

# 1.0.0 (2025-03-04)


### Bug Fixes

* **workflow:** Added docker username and token secrets ([262d5b2](https://github.com/webgrip/n8n-application/commit/262d5b210f0b917997b9a9b804c8126aa80a9613))
* **workflow:** Fix docker build context ([64313bc](https://github.com/webgrip/n8n-application/commit/64313bcd4792775791625b9ebc0a248e9cd864e3))
