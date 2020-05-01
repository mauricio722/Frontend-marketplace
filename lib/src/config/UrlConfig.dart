class UrlConfig {
  String host;
  String port;
  String uri;

  UrlConfig() {
    // this.host = '192.168.137.1';
    // this.port = '3000';
    // this.uri = 'api/marketplace-gateway-ms';
    this.host = '104.154.23.227';
    this.port = '80';
    this.uri = 'easybuy/api/marketplace-gateway-ms';
  }

  String getUri() {
    String url = 'http://$host:$port/$uri';
    return url;
  }
}
