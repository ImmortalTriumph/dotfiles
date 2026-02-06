vim.filetype.add({
  extension = {
    jsx = "javascriptreact",
    tsx = "typescriptreact",
  },
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    [".gitlab-ci.yml"] = "yaml.gitlab",
  },
  pattern = {
    ["docker%-compose%..*%.ya?ml"] = "yaml.docker-compose",
    [".*%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
    [".*/helm/.*/values%.ya?ml"] = "yaml.helm-values",
    [".*/charts/.*/values%.ya?ml"] = "yaml.helm-values",
  },
})
