cere_id(){
  docker container ls | grep -oP '\w+(?=\s+cerebellum)'
}
cere_id_long() {
  docker ps --no-trunc | grep -oP '\w+(?=\s+cerebellum)'
}
cere_log_size(){
  sudo ls -hal /var/lib/docker/containers/$(cere_id_long)/$(cere_id_long)-json.log | cut -d " " -f 5
}
