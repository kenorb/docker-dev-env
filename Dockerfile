FROM ansible/ansible:ubuntu1604py3
MAINTAINER kenorb
ENV DEBIAN_FRONTEND noninteractive
RUN pip3 install ansible
RUN printf "APT::Install-Recommends 0;\r\nAPT::Install-Suggests 0;\r\n" > /etc/apt/apt.conf.d/01norecommend
RUN printf '[local]\r\nlocalhost ansible_python_interpreter="env python3"\r\n' > /etc/ansible/hosts
ADD ansible /ansible
ADD scripts /ansible/scripts
RUN ansible-playbook /ansible/provision.yml -c local
RUN useradd -d /home/ubuntu -ms /bin/bash -g root -G sudo -p ubuntu ubuntu
USER ubuntu
WORKDIR /home/ubuntu
CMD ["/bin/bash"]
