# BEVM TESTNET NODE CONFIGURATION

## DOWNLOAD INSTALATION SCRIPT

```
wget https://raw.githubusercontent.com/Zlkcyber/node/main/bevm/bevm.sh
```
Make it executable 
```
chmod +x bevm.sh
```
and run it
```
./bevm.sh
```

## If you want to get incentives from the BEVM TestNet FullNode Program, set "your_node_name" as the BEVM address.

```
sudo docker run -d -v /var/lib/node_bevm_test_storage:/root/.local/share/bevm btclayer2/bevm:v0.1.1 bevm "--chain=testnet" "--name=your_node_name" "--pruning=archive" --telemetry-url "wss://telemetry.bevm.io/submit 0"
```
