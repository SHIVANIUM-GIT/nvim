############################
#  System
############################
alias cls='clear'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

############################
#  Git
############################
alias g='git'
alias ga='git add .'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gpl='git pull'
alias gpr='git pull --rebase'
alias gp='git push'
alias gpsu='git push -u origin HEAD'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate'
alias gs='git status'
alias gb='git branch'
alias gbd='git branch -d'

############################
#  Kubernetes (Minikube)
############################
alias k="minikube kubectl --"
alias kgp="k get pods"
alias kgs="k get svc"
alias kgd="k get deployments"
alias kga="k get all"

############################
# Terraform
############################
alias tf="terraform"
alias tfi="terraform init"
alias tff="terraform fmt"
alias tfv="terraform validate"
alias tfp="terraform plan"
alias tfa="terraform apply"
alias tfd="terraform destroy"
alias tfo="terraform output"

############################
#  Docker
############################
alias d="docker"
alias dps="docker ps"
alias dpa="docker ps -a"
alias di="docker images"
alias db="docker build -t"
alias dr="docker run -it"
alias drm="docker rm"
alias drmi="docker rmi"
alias dlog="docker logs"
alias dlogf="docker logs -f"
alias dex="docker exec -it"
