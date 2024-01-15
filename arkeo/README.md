# ARKEOD DATA PROVIDER TESTNET

## Details
- Network Chain ID: arkeo
- Denom: uarkeo
- Binary: arkeod
- Working directory: .arkeo
- RPC: https://t-arkeo.rpc.utsa.tech/
- RPC ETH: https://chainlist.org/chain/1
- API: https://t-arkeo.api.utsa.tech/
- Explorers: https://exp.utsa.tech/arkeo-test/staking
- Docs: https://docs.arkeo.network/architecture/providers

apt update &amp;&amp; apt upgrade -y

# устанавливаем необходимые утилиты
apt install curl iptables build-essential git wget jq make gcc nano tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev -y</pre><p data-anchor="M4EP" data-node-id="54"><a name="M4EP"></a><!--[--><!--]--><!--[--><strong data-node-id="55">File2Ban</strong> - подробнее <a href="https://putty.org.ru/articles/fail2ban-ssh.html" target="_blank" data-node-id="56"><!--[-->здесь<!--]--></a> и <a href="https://www.linuxshop.ru/articles/a26710798-nastroyka_fail2ban" target="_blank" data-node-id="57"><!--[-->здесь<!--]--></a><!--]--></p><pre data-lang="bash" data-anchor="Eq8Q" data-node-id="58"># устанавливаем и копируем конфиг, который будет иметь больший приоритет
apt install fail2ban -y &amp;&amp; \
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local &amp;&amp; \
nano /etc/fail2ban/jail.local
# раскомментировать и добавить свой IP: ignoreip = 127.0.0.1/8 ::1 &lt;ip&gt;
systemctl restart fail2ban

# проверяем status 
systemctl status fail2ban
# проверяем, какие jails активны (по умолчанию только sshd)
fail2ban-client status
# проверяем статистику по sshd
fail2ban-client status sshd
# смотрим логи
tail /var/log/fail2ban.log
# останавливаем работу и удаляем с автозагрузки
#systemctl stop fail2ban &amp;&amp; systemctl disable fail2ban</pre><p data-anchor="lvZ3" data-node-id="59"><a name="lvZ3"></a><!--[--><!--]--><!--[--><strong data-node-id="60">Устанавливаем GO</strong><!--]--></p><pre data-lang="bash" data-anchor="ZQka" data-node-id="61">ver=&quot;1.20.3&quot; &amp;&amp; \
wget &quot;https://golang.org/dl/go$ver.linux-amd64.tar.gz&quot; &amp;&amp; \
sudo rm -rf /usr/local/go &amp;&amp; \
sudo tar -C /usr/local -xzf &quot;go$ver.linux-amd64.tar.gz&quot; &amp;&amp; \
rm &quot;go$ver.linux-amd64.tar.gz&quot; &amp;&amp; \
echo &quot;export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin&quot; &gt;&gt; $HOME/.bash_profile &amp;&amp; \
source $HOME/.bash_profile &amp;&amp; \
go version</pre><p data-anchor="E2u0" data-node-id="62"><a name="E2u0"></a><!--[--><!--]--><!--[--><strong data-node-id="63">Устанавливаем docker + docker-compose</strong><!--]--></p><pre data-lang="bash" data-anchor="meS2" data-node-id="64"># https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-ru
apt update &amp;&amp; \
apt install apt-transport-https ca-certificates curl software-properties-common -y &amp;&amp; \
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &amp;&amp; \
add-apt-repository &quot;deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable&quot; &amp;&amp; \
apt update &amp;&amp; \
apt-cache policy docker-ce &amp;&amp; \
sudo apt install docker-ce -y &amp;&amp; \
docker --version</pre><pre data-lang="bash" data-anchor="rZcr" data-node-id="65"># ручная установка docker-compose https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04-ru
# проверяем версию https://github.com/docker/compose/releases и подставляем в команду установки
curl -L &quot;https://github.com/docker/compose/releases/download/v2.10.1/docker-compose-$(uname -s)-$(uname -m)&quot; -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose

# проверить версию
docker-compose --version</pre><p data-anchor="SwCa" data-node-id="66"><a name="SwCa"></a><!--[--><!--]--><!--[--><!--]--></p><section bg="hsl(34,  84%, var(--autocolor-background-lightness, 95%))" data-anchor="dde5" style="background-color:hsl(34,  84%, var(--autocolor-background-lightness, 95%));" data-node-id="67"><!----><!--[--><!--]--><!--[--><h2 data-anchor="CDmC" data-node-id="68"><a name="CDmC"></a><!--[--><!--]--><!--[-->Настройка ноды Arkeo<!--]--></h2><!--]--></section><p data-anchor="wJBO" data-node-id="69"><a name="wJBO"></a><!--[--><!--]--><!--[--><strong data-node-id="70">Для того чтобы запустить провайдера нам необходимо:</strong><!--]--></p><ul data-anchor="9IUq" data-node-id="71"><!----><!--[--><!--]--><!--[--><li data-anchor="teKO" data-node-id="72"><a name="teKO"></a><!--[--><!--]--><!--[-->Установить и синхронизировать ноду Arkeo. Для этого Вы можете воспользоваться <a href="/@lesnik13utsa/pdaQdlKWbWS" class="" data-node-id="73"><!--[-->данным гайдом<!--]--></a><!--]--></li><li data-anchor="4X5o" data-node-id="74"><a name="4X5o"></a><!--[--><!--]--><!--[-->Настройки индексации и прунинга на ноде могут быть любые<!--]--></li><li data-anchor="bKbD" data-node-id="75"><a name="bKbD"></a><!--[--><!--]--><!--[-->Создать новый кошелек и пополнить его минимум на 2 монеты<!--]--></li><li data-anchor="rOWL" data-node-id="76"><a name="rOWL"></a><!--[--><!--]--><!--[-->Получить pubkey нашего кошелька в формате <strong data-node-id="77">tarkeopub1ad...</strong> Его нам нужно будет вставить в конфигурацию <strong data-node-id="78">sentinel </strong>и отправить необходимые транзакции<!--]--></li><!--]--></ul><pre data-anchor="65hv" data-lang="bash" data-node-id="79"># создать кошелек
arkeod keys add arkeo_provider_wallet --keyring-backend os</pre><pre data-anchor="WgJw" data-lang="bash" data-node-id="80"># проверяем баланс
arkeod q bank balances &lt;address&gt;</pre><p data-anchor="m90B" data-node-id="81"><a name="m90B"></a><!--[--><!--]--><!--[--><!--]--></p><section data-anchor="NqWG" bg="hsl(34,  84%, var(--autocolor-background-lightness, 95%))" style="background-color:hsl(34,  84%, var(--autocolor-background-lightness, 95%));" data-node-id="82"><!----><!--[--><!--]--><!--[--><h2 data-anchor="1b58" data-node-id="83"><a name="1b58"></a><!--[--><!--]--><!--[-->Настройка sentinel<!--]--></h2><!--]--></section><blockquote data-anchor="j0l1" data-node-id="84"><a name="j0l1"></a><!--[--><!--]--><!--[--><strong data-node-id="85">Sentinel - это специально созданный обратный прокси-сервер (похожий на nginx). Его роль - быть фронтальными службами, которые пересылают запросы к внутренним службам (т. е. RPC). Он также отвечает за аутентификацию/авторизацию, а также услуги ограничения скорости</strong><!--]--></blockquote><p data-anchor="96S9" data-node-id="86"><a name="96S9"></a><!--[--><!--]--><!--[--><strong data-node-id="87">Создаем каталог и переходим в него</strong><!--]--></p><pre data-lang="bash" data-anchor="loDq" data-node-id="88">cd
mkdir -p arkeo-provider &amp;&amp; cd arkeo-provider</pre><p data-anchor="Wt09" data-node-id="89"><a name="Wt09"></a><!--[--><!--]--><!--[--><strong data-node-id="90">Создаем docker-compose.yml</strong><!--]--></p><blockquote data-anchor="b8Z4" data-node-id="91"><a name="b8Z4"></a><!--[--><!--]--><!--[-->image - <a href="https://github.com/arkeonetwork/arkeo/pkgs/container/arkeo" target="_blank" data-node-id="92"><!--[-->https://github.com/arkeonetwork/arkeo/pkgs/container/arkeo<!--]--></a><!--]--></blockquote><p data-anchor="S0nu" data-node-id="93"><a name="S0nu"></a><!--[--><!--]--><!--[-->Создаем docker-compose.yml и вставляем конфиг. В конфиге меняем <strong data-node-id="94">PROVIDER_PUBKEY</strong> и <strong data-node-id="95">ETH_MAINNET_FULLNODE</strong><!--]--></p><section bg="hsl(236, 74%, var(--autocolor-background-lightness, 95%))" data-anchor="yClq" style="background-color:hsl(236, 74%, var(--autocolor-background-lightness, 95%));" data-node-id="96"><!----><!--[--><!--]--><!--[--><p data-anchor="3D5v" data-node-id="97"><a name="3D5v"></a><!--[--><!--]--><!--[-->Не обязательно использовать ETH_MAINNET_FULLNODE, вместо этого Вы можете взять RPC любой другой поддерживаемой сети. Список поддерживаемых сетей - <a href="https://github.com/arkeonetwork/arkeo/blob/master/common/service.go#L20" target="_blank" data-node-id="98"><!--[-->https://github.com/arkeonetwork/arkeo/blob/master/common/service.go#L20<!--]--></a><!--]--></p><!--]--></section><pre data-anchor="Ucd6" data-lang="bash" data-node-id="99">nano docker-compose.yml</pre><pre data-anchor="NuYN" data-lang="bash" data-node-id="100">version: &quot;3&quot;
services:
  sentinel:
    image: ghcr.io/arkeonetwork/arkeo:latest
    container_name: sentinel
    environment:
      NET: &quot;mainnet&quot;
      MONIKER: &quot;n/a&quot;
      WEBSITE: &quot;n/a&quot;
      DESCRIPTION: &quot;n/a&quot;
      LOCATION: &quot;Europe&quot;
      FREE_RATE_LIMIT: 10
      PROVIDER_PUBKEY: &quot;&lt;tarkeopub1add...&gt;&quot;
      SOURCE_CHAIN: &quot;127.0.0.1:1317&quot;
      EVENT_STREAM_HOST: &quot;127.0.0.1:26657&quot;
      CLAIM_STORE_LOCATION: &quot;${HOME}/.arkeo/claims&quot;
      CONTRACT_CONFIG_STORE_LOCATION: &quot;${HOME}/.arkeo/contract_configs&quot;
      ETH_MAINNET_FULLNODE: &quot;&lt;https://ethereum.mainnet.fi&gt;&quot;
    network_mode: host
    entrypoint: sentinel</pre><p data-anchor="Hdoc" data-node-id="101"><a name="Hdoc"></a><!--[--><!--]--><!--[--><strong data-node-id="102">Запускаем sentinel</strong><!--]--></p><pre data-lang="bash" data-anchor="F6po" data-node-id="103">docker-compose up -d</pre><p data-anchor="5oo7" data-node-id="104"><a name="5oo7"></a><!--[--><!--]--><!--[--><strong data-node-id="105">Проверяем логи</strong><!--]--></p><pre data-lang="bash" data-anchor="Lvv5" data-node-id="106">docker-compose logs -f --tail 100</pre><figure class="m_custom" data-anchor="TudP" itemscope itemtype="http://schema.org/ImageObject" data-node-id="107"><a name="TudP"></a><!--[--><!--]--><div class="wrap"><!----><!--[--><noscript><img src="https://img4.teletype.in/files/b6/12/b6126ff2-0ccb-48f8-ba80-192393582c5f.png" itemprop="contentUrl"></noscript><svg class="spacer" version="1.1" width="981" viewbox="0 0 981 296"></svg><!--]--><div class="loader"><div class="preloader m_central" data-v-3fc407d9><svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" viewBox="0 0 32 32" class="icon" data-icon="preloader" data-v-3fc407d9><path fill-rule="evenodd" d="M7.5 16a8.5 8.5 0 0111.156-8.077.5.5 0 11-.312.95A7.5 7.5 0 1023.5 16a.5.5 0 011 0 8.5 8.5 0 01-17 0z" clip-rule="evenodd"></path></svg></div></div></div><!--[--><!--[--><!----><!--]--><!--]--></figure><blockquote data-anchor="8Ci7" data-node-id="109"><a name="8Ci7"></a><!--[--><!--]--><!--[--><strong data-node-id="110">После запуска мы можем проверить наш sentinel через http://&lt;IP_SERVER&gt;:3636/metadata.json</strong><!--]--></blockquote><p data-anchor="Ed4a" data-node-id="111"><a name="Ed4a"></a><!--[--><!--]--><!--[--><!--]--></p><p data-anchor="Tzdj" data-node-id="112"><a name="Tzdj"></a><!--[--><!--]--><!--[--><strong data-node-id="113">Получаем наш PubKey</strong><!--]--></p><pre data-anchor="oeny" data-lang="bash" data-node-id="114">RAWPUBKEY=$(arkeod keys show arkeo_provider_wallet -p | jq -r .key) &amp;&amp;\
PUBKEY=$(arkeod debug pubkey-raw $RAWPUBKEY | grep &#39;Bech32 Acc:&#39; | sed &quot;s|Bech32 Acc: ||g&quot;) &amp;&amp;\
echo $PUBKEY</pre><p data-anchor="fg8i" data-node-id="115"><a name="fg8i"></a><!--[--><!--]--><!--[--><strong data-node-id="116">Вводим недостающие переменные и отправляем транзакцию BOND</strong><!--]--></p><blockquote data-anchor="iWmF" data-node-id="117"><a name="iWmF"></a><!--[--><!--]--><!--[-->Вы должны сделать это для каждой службы, которую вы собираетесь запустить (например, Bitcoin, Ethereum, Gaia и т.д.)<!--]--></blockquote><p data-anchor="A0eb" data-node-id="118"><a name="A0eb"></a><!--[--><!--]--><!--[-->SERVICE прописаны <a href="https://github.com/arkeonetwork/arkeo/blob/master/common/service.go#L20" target="_blank" data-node-id="119"><!--[-->здесь<!--]--></a><!--]--></p><pre data-anchor="Symy" data-lang="bash" data-node-id="120">SERVICE=eth-mainnet-fullnode
BOND=1000000</pre><pre data-anchor="Symy" data-lang="bash" data-node-id="121">arkeod tx arkeo bond-provider -y --from arkeo_provider_wallet --fees 200uarkeo -- &quot;$PUBKEY&quot; &quot;$SERVICE&quot; &quot;$BOND&quot;</pre><section bg="hsl(236, 74%, var(--autocolor-background-lightness, 95%))" data-anchor="KC2P" style="background-color:hsl(236, 74%, var(--autocolor-background-lightness, 95%));" data-node-id="122"><!----><!--[--><!--]--><!--[--><p data-anchor="zOXX" data-node-id="123"><a name="zOXX"></a><!--[--><!--]--><!--[-->Теперь мы можем проверить нашего провайдера командой. Предварительно замените <strong data-node-id="124">&lt;tarkeopub1...&gt;</strong> на свое значение<!--]--></p><pre data-anchor="fBLr" data-lang="bash" data-node-id="125">curl -s &quot;https://t-arkeo.api.utsa.tech/arkeo/providers&quot; | jq &#39;.provider[]|select(.pub_key==&quot;&lt;tarkeopub1...&gt;&quot;)&#39;</pre><figure class="m_original" data-anchor="pjkJ" itemscope itemtype="http://schema.org/ImageObject" data-node-id="126"><a name="pjkJ"></a><!--[--><!--]--><div class="wrap"><!----><!--[--><noscript><img src="https://img1.teletype.in/files/8e/fa/8efa3569-b542-4fab-87c3-b3e92354df26.png" itemprop="contentUrl"></noscript><svg class="spacer" version="1.1" width="639" viewbox="0 0 639 283"></svg><!--]--><div class="loader"><div class="preloader m_central" data-v-3fc407d9><svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" viewBox="0 0 32 32" class="icon" data-icon="preloader" data-v-3fc407d9><path fill-rule="evenodd" d="M7.5 16a8.5 8.5 0 0111.156-8.077.5.5 0 11-.312.95A7.5 7.5 0 1023.5 16a.5.5 0 011 0 8.5 8.5 0 01-17 0z" clip-rule="evenodd"></path></svg></div></div></div><!--[--><!--[--><!----><!--]--><!--]--></figure><!--]--></section><p data-anchor="Yj0x" data-node-id="128"><a name="Yj0x"></a><!--[--><!--]--><!--[--><strong data-node-id="129">Модификация провайдера</strong> - <strong data-node-id="130">замените на свои значения </strong><a href="https://docs.arkeo.network/how-to-use/data-providers/management#modifying" target="_blank" data-node-id="131"><!--[-->https://docs.arkeo.network/how-to-use/data-providers/management#modifying<!--]--></a><!--]--></p><pre data-anchor="5M0s" data-lang="bash" data-node-id="132">PUBKEY=&lt;tarkeopub1...&gt;
SERVICE=eth-mainnet-fullnode
METADATAURI=http://arkeo-provider.utsa.tech:3636/metadata.json
# METADATANONCE должно увеличиваться каждый раз, когда Вы модифицируете или изменяете содержимое metadata.json в sentinel
METADATANONCE=1
# STATUS позволяет Вам сигнализировать о том, что Вы находитесь в режиме технического обслуживания. 0=offline 1= online
STATUS=1
# MIN_CONTRACT_DURATION устанавливает минимальный срок действия контракта
MIN_CONTRACT_DURATION=5
# MAX_CONTRACT_DURATION устанавливает максимальную продолжительность контракта. Это гарантирует, что контракты не будут открыты слишком долго, что затруднит корректировку цен
MAX_CONTRACT_DURATION=432000
# SUBSCRIPTION_RATE позволяет Вам устанавливать свои цены на контракты подписи. Вы можете указать любые активы с поддержкой IBC, такие как ATOM, ARKEO или USDC
SUBSCRIPTION_RATE=10uarkeo
# PAY_AS_YOU_GO_RATE - то же, что и SUBSCRIPTION_RATE, но для контрактов с оплатой по мере поступления
PAY_AS_YOU_GO_RATE=10uarkeo
# SETTLEMENT_DURATION дает провайдеру дополнительное время после истечения срока действия контракта для подачи любых заявлений о вознаграждении (для контрактов с оплатой по мере поступления)
SETTLEMENT_DURATION=1000</pre><pre data-anchor="XdPR" data-lang="bash" data-node-id="133">arkeod tx arkeo mod-provider -y --from arkeo_provider_wallet --fees 200uarkeo -- &quot;$PUBKEY&quot; &quot;$SERVICE&quot; &quot;$METADATAURI&quot; $METADATANONCE $STATUS $MIN_CONTRACT_DURATION $MAX_CONTRACT_DURATION $SUBSCRIPTION_RATE  $PAY_AS_YOU_GO_RATE $SETTLEMENT_DURATION</pre><section bg="hsl(236, 74%, var(--autocolor-background-lightness, 95%))" data-anchor="zRcu" style="background-color:hsl(236, 74%, var(--autocolor-background-lightness, 95%));" data-node-id="134"><!----><!--[--><!--]--><!--[--><p data-anchor="7Ei9" data-node-id="135"><a name="7Ei9"></a><!--[--><!--]--><!--[-->Теперь состояние провайдера должно измениться. Предварительно замените <strong data-node-id="136">&lt;tarkeopub1...&gt;</strong> на свое значение<!--]--></p><pre data-anchor="zUsx" data-lang="bash" data-node-id="137">curl -s &quot;https://t-arkeo.api.utsa.tech/arkeo/providers&quot; | jq &#39;.provider[]|select(.pub_key==&quot;&lt;tarkeopub1...&gt;&quot;)&#39;</pre><figure class="m_original" data-anchor="5CX6" itemscope itemtype="http://schema.org/ImageObject" data-node-id="138"><a name="5CX6"></a><!--[--><!--]--><div class="wrap"><!----><!--[--><noscript><img src="https://img1.teletype.in/files/07/a3/07a3b789-1949-44cc-b217-bcea500a4066.png" itemprop="contentUrl"></noscript><svg class="spacer" version="1.1" width="719" viewbox="0 0 719 491"></svg><!--]--><div class="loader"><div class="preloader m_central" data-v-3fc407d9><svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" viewBox="0 0 32 32" class="icon" data-icon="preloader" data-v-3fc407d9><path fill-rule="evenodd" d="M7.5 16a8.5 8.5 0 0111.156-8.077.5.5 0 11-.312.95A7.5 7.5 0 1023.5 16a.5.5 0 011 0 8.5 8.5 0 01-17 0z" clip-rule="evenodd"></path></svg></div></div></div><!--[--><!--[--><!----><!--]--><!--]--></figure><!--]--></section><p data-anchor="ndoT" data-node-id="140"><a name="ndoT"></a><!--[--><!--]--><!--[-->На этом этапе Ваш провайдер должен работать, если кто-то создаст контракт с Вашим провайдером, то можно будет клеймить награды. <strong data-node-id="141">В настоящее время имеется недостаточное количество контрактов для всех провайдеров, поэтому каждый из Вас может самостоятельно создать контракт и протестировать общую работу!</strong><!--]--></p><p data-anchor="r6Sk" data-node-id="142"><a name="r6Sk"></a><!--[--><!--]--><!--[--><!--]--></p><section data-anchor="hVMF" bg="hsl(236, 74%, var(--autocolor-background-lightness, 95%))" style="background-color:hsl(236, 74%, var(--autocolor-background-lightness, 95%));" data-node-id="143"><!----><!--[--><!--]--><!--[--><h2 data-anchor="1eUH" data-node-id="144"><a name="1eUH"></a><!--[--><!--]--><!--[-->Полезные команды<!--]--></h2><!--]--></section><pre data-anchor="ap8W" data-lang="bash" data-node-id="145">cd arkeo-provider

# запуск sentinel
docker-compose up -d

# проверяем логи
docker-compose logs -f --tail 100

# рестарт sentinel
docker-compose restart

# остановить sentinel
docker-compose stop


# Остановить ноду и удалить тома данных
docker-compose down -v</pre><p data-anchor="Zs3a" data-node-id="146"><a name="Zs3a"></a><!--[--><!--]--><!--[--><strong data-node-id="147">Проверить всех провайдеров</strong><!--]--></p><pre data-anchor="CmG3" data-lang="bash" data-node-id="148">curl -s &quot;https://t-arkeo.api.utsa.tech/arkeo/providers&quot; | jq</pre><p data-anchor="1Aw1" data-node-id="149"><a name="1Aw1"></a><!--[--><!--]--><!--[--><strong data-node-id="150">Проверить определенного провайдера</strong><!--]--></p><pre data-anchor="ki8n" data-lang="bash" data-node-id="151">curl -s &quot;https://t-arkeo.api.utsa.tech/arkeo/providers&quot; | jq &#39;.provider[]|select(.pub_key==&quot;tarkeopub1addwnpepq2gehntdwz26s6jhzmfv89enucmx7dls76zzkmq4hw5mwxdzkplk75ke05z&quot;)&#39;</pre><p data-anchor="lpTC" data-node-id="152"><a name="lpTC"></a><!--[--><!--]--><!--[--><strong data-node-id="153">Проверить метаданные определенного провайдера</strong><!--]--></p><pre data-anchor="4bjx" data-lang="bash" data-node-id="154">curl -s http://arkeo-provider.utsa.tech:3636/metadata.json | jq</pre><pre data-anchor="4bjx" data-lang="bash" data-node-id="155">curl -sX POST -H &quot;Content-Type: application/json&quot; -d &#39;{&quot;jsonrpc&quot;:&quot;2.0&quot;,&quot;method&quot;:&quot;eth_blockNumber&quot;,&quot;params&quot;:[],&quot;id&quot;:1}&#39; http://arkeo-provider.utsa.tech:3636/eth-mainnet-fullnode|jq</pre><p data-anchor="jHso" data-node-id="156"><a name="jHso"></a><!--[--><!--]--><!--[--><strong data-node-id="157">Проверить активные контракты</strong><!--]--></p><pre data-anchor="9gsa" data-lang="bash" data-node-id="158">curl -s http://&lt;ip-address&gt;:3636/active-contract/&lt;service&gt;/&lt;spender_pubkey&gt; | jq</pre><p data-anchor="QNul" data-node-id="159"><a name="QNul"></a><!--[--><!--]--><!--[--><strong data-node-id="160">Claims</strong><!--]--></p><pre data-anchor="Cl6m" data-lang="bash" data-node-id="161"># 
curl -s http://&lt;ip-address&gt;:3636/claim/&lt;contract_id&gt; | jq
# открытые для claim
curl -s http://&lt;ip-address&gt;:3636/open-claims | jq</pre><p data-anchor="YiA1" data-node-id="162"><a name="YiA1"></a><!--[--><!--]--><!--[--><strong data-node-id="163">Сделать unbond</strong><!--]--></p><pre data-anchor="CHwv" data-lang="bash" data-node-id="164">RAWPUBKEY=$(arkeod keys show arkeo_provider_wallet -p | jq -r .key) &amp;&amp;\
PUBKEY=$(arkeod debug pubkey-raw $RAWPUBKEY | grep &#39;Bech32 Acc:&#39; | sed &quot;s|Bech32 Acc: ||g&quot;) &amp;&amp;\
echo $PUBKEY

SERVICE=eth-mainnet-fullnode
BOND=-1000000
arkeod tx arkeo bond-provider -y --from arkeo_provider_wallet --fees 200uarkeo -- &quot;$PUBKEY&quot; &quot;$SERVICE&quot; &quot;$BOND&quot;</pre><figure class="m_original" data-anchor="qwz6" data-caption-align="center" itemscope itemtype="http://schema.org/ImageObject" data-node-id="165"><a name="qwz6"></a><!--[--><!--]--><div class="wrap"><!----><!--[--><noscript><img src="https://img4.teletype.in/files/fe/df/fedf6526-2630-4880-a71d-cdf5855a374c.png" itemprop="contentUrl"></noscript><svg class="spacer" version="1.1" width="278" viewbox="0 0 278 257"></svg><!--]--><div class="loader"><div class="preloader m_central" data-v-3fc407d9><svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" viewBox="0 0 32 32" class="icon" data-icon="preloader" data-v-3fc407d9><path fill-rule="evenodd" d="M7.5 16a8.5 8.5 0 0111.156-8.077.5.5 0 11-.312.95A7.5 7.5 0 1023.5 16a.5.5 0 011 0 8.5 8.5 0 01-17 0z" clip-rule="evenodd"></path></svg></div></div></div><!--[--><!--[--><figcaption itemprop="description"><!----><!--[--><!--]--><!--[--><strong data-node-id="167">Поддержим природу вместе:
0xa7476EC14cD663C742d527113638C77a1631Cc89