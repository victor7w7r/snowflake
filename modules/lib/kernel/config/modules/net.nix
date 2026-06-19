{
  kernel.config.modules.net = {
    DEFAULT_CUBIC = "n";
    DEFAULT_FQ_CODEL = "n";
    DEFAULT_BBR = "y";
    DEFAULT_HOSTNAME = "v7w7r";
    DEFAULT_NET_SCH = "fq";
    DEFAULT_TCP_CONG = "bbr";
    NETFILTER_NETLINK = "y";
    NETFILTER_NETLINK_ACCT = "y";
    NETFILTER_NETLINK_LOG = "y";
    NETFILTER_NETLINK_OSF = "y";
    NETFILTER_NETLINK_QUEUE = "y";
    NET_SCH_FQ = "y";
    TCP_CONG_BBR = "y";
  };
}
