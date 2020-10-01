# Playbook para preparar VMs de Vagrant para laboratórios

Essa playbook faz uma preparação básica de VMs para laboratórios:

- Instala e configura autodiscovery das máquinas em rede local
- Configura acesso por ssh sem senha do usuário no host para cada VM
- atualiza os pacotes

## Vagrantfile

Adicione um provisionamento parecido com:

```ruby
      config.vm.provision "ansible" do |ansible|
        ansible.playbook = "vagrant/vagrant.yml"
        ansible.host_vars = { hostname => {"ip" => maquina["ansible_host"]} }
      end
```

Ou use o exemplo de: [tureba/postgresql-lab](https://github.com/tureba/postgresql-lab)
