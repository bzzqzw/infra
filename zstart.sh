
case $1 in
"init")
    ansible-playbook deploy.yaml -e env=$2 -e operation=init
    ;;
"destroy")
    ansible-playbook deploy.yaml -e env=$2 -e operation=destroy
    ;;
"create")
    ansible-playbook deploy.yaml -e env=$2 -e operation=create
    ;;
"create-plan" | *)
    ansible-playbook deploy.yaml -e env=$2 -e operation=create-plan
    if [ ! -f "/tf/plan.tfplan" ]; then
        (
            cd tf
            terraform show plan.tfplan
        )
    fi
    ;;
esac
