FROM registry.suse.de/suse/containers/sle-server/12-sp4/containers/suse/sles12sp4

RUN zypper addrepo --refresh http://download.nue.suse.com/update/build.suse.de/SUSE/Products/SLE-SDK/12-SP4/x86_64/product/ SDK
RUN zypper addrepo --refresh http://download.nue.suse.com/update/build.suse.de/SUSE/Updates/SLE-SDK/12-SP4/x86_64/update/   SDK-Update
RUN zypper addrepo --refresh http://download.nue.suse.com/ibs/SUSE:/CA/SLE_12_SP4/                                          SUSE-CA
RUN zypper addrepo --refresh http://download.suse.de/ibs/SUSE/Updates/SLE-Live-Patching/12/x86_64/update/                   live-patching
RUN zypper addrepo --refresh http://clouddata.cloud.suse.de/repos/x86_64/SLES12-SP4-Pool/                                   pool
RUN zypper addrepo --refresh http://clouddata.cloud.suse.de/repos/x86_64/SLES12-SP4-Updates/                                up
RUN zypper addrepo --refresh http://download.suse.de/ibs/SUSE:/SLE-12-SP4:/GA/standard/                                     12-SP4-GA
RUN zypper addrepo --refresh http://download.suse.de/ibs/SUSE:/SLE-12-SP4:/Update/standard/                                 12-SP4-Update
RUN zypper addrepo --refresh http://download.suse.de/ibs/SUSE:/SLE-12-SP3:/GA/standard/                                     12-SP3-GA
RUN zypper addrepo --refresh http://download.suse.de/ibs/SUSE:/SLE-12-SP3:/Update/standard/                                 12-SP3-Update
RUN zypper addrepo --refresh http://download.suse.de/ibs/SUSE:/SLE-12-SP2:/GA/standard/                                     12-SP2-GA
RUN zypper addrepo --refresh http://download.suse.de/ibs/SUSE:/SLE-12-SP2:/Update/standard/                                 12-SP2-Update
RUN zypper addrepo --refresh http://download.suse.de/ibs/SUSE:/SLE-12-SP1:/GA/standard/                                     12-SP1-GA
RUN zypper addrepo --refresh http://download.suse.de/ibs/SUSE:/SLE-12-SP1:/Update/standard/                                 12-SP1-Update
RUN zypper addrepo --refresh http://download.suse.de/ibs/SUSE:/SLE-12:/GA/standard/                                         12-GA
RUN zypper addrepo --refresh http://download.suse.de/ibs/SUSE:/SLE-12:/Update/standard/                                     12-Update
RUN zypper addrepo --refresh http://download.suse.de/ibs/SUSE:/Factory:/Head/standard/                                      factory

RUN zypper --gpg-auto-import-keys refresh

RUN zypper --non-interactive --gpg-auto-import-keys install \
        autoconf \
        automake \
        ca-certificates-suse \
        gcc \
        git-core \
        python-devel \
        python-virtualenv \
        python3 \
        python3-devel \
        python3-virtualenv \
        sshpass

ARG python
RUN virtualenv --python ${python:-python2.7} /opt/ansible-venv
RUN /opt/ansible-venv/bin/pip install --upgrade pip
COPY requirements.txt /tmp/requirements.txt
RUN /opt/ansible-venv/bin/pip install --requirement /tmp/requirements.txt
RUN /opt/ansible-venv/bin/pip install python-openstackclient python-heatclient

ARG git_user_name
ARG git_user_email
RUN git config --global user.name "${git_user_name:-Unknown User}"
RUN git config --global user.email "${git_user_email:-unknown@unknown.org}"

VOLUME ["/opt/automation"]
WORKDIR /opt/automation/scripts/jenkins/cloud/manual
ENV ANSIBLE_VENV /opt/ansible-venv
ENV CLIFF_FIT_WIDTH=1
RUN ["/bin/bash", "-c", "echo . /opt/ansible-venv/bin/activate >> /root/.bashrc"]
CMD /bin/bash
