package App::CharmKit::Helper;

# ABSTRACT: charm helpers

=head1 SYNOPSIS

  use App::CharmKit::Helper;

or

  use charm -helper;

  my $port = config_get 'port';
  my $database = relation_get 'database';
  my $dbuser = relation_get 'user';

=head1 DESCRIPTION

Charm helpers for composition

=cut

use App::CharmKit::Sys qw/execute/;
use Exporter qw/import/;

our @EXPORT = qw/config_get
  relation_ids
  relation_get
  relation_set
  relation_list
  open_port
  close_port
  unit_get/;

=func service_control(STR service_name, STR action)

Controls a upstart service

=cut
sub service_control {
    my $service_name = shift;
    my $action       = shift;
    my $cmd          = ['service', $service_name, $action];
    my $ret          = execute($cmd);
    return $ret->{stdout};
}

=func config_get(STR option)

Queries a config option

=cut
sub config_get {
    my ($key) = @_;
    my $cmd = ['config-get', $key];
    my $ret = execute($cmd);
    return $ret->{stdout};
}

=func relation_get(STR attribute, STR unit, STR rid)

Gets relation

=cut
sub relation_get {
    my $attribute = shift || undef;
    my $unit      = shift || undef;
    my $rid       = shift || undef;
    my $cmd       = ['relation-get'];

    if ($rid) {
        push @{$cmd}, '-r';
        push @{$cmd}, $rid;
    }
    if ($attribute) {
        push @{$cmd}, $attribute;
    }
    if ($unit) {
        push @{$cmd}, $unit;
    }
    my $ret = execute($cmd);
    return $ret->{stdout};
}

=func relation_set(HASHREF opts)

Relation set

=cut
sub relation_set {
    my $opts = shift;
    my $cmd  = ['relation-set'];
    my $opts_str;
    foreach my $key (keys %{$opts}) {
        $opts_str .= sprintf("%s=%s ", $key, $opts->{$key});
    }
    push @{$cmd}, $opts_str;
    my $ret = execute($cmd);
    return $ret->{stdout};
}

=func relation_ids(STR relation_name)

Get relation ids

=cut
sub relation_ids {
  my ($relation_name) = @_;
  my $cmd = ['relation-ids', $relation_name];
  my $ret = execute($cmd);
  return $ret->{stdout};
}

=func relation_list(INT rid)

Relation list

=cut
sub relation_list {
    my $rid = shift || undef;
    my $cmd = ['relation-list'];
    if ($rid) {
        push @{$cmd}, '-r';
        push @{$cmd}, $rid;
    }
    my $ret = execute($cmd);
    return $ret->{stdout};
}

=func unit_get(STR key)

Get unit information

=cut
sub unit_get {
  my ($key) = @_;
  my $cmd = ['unit-get', $key];
  my $ret = execute($cmd);
  return $ret->{stdout};
}

=func open_port(INT port, STR protocol)

Open port on service

=cut
sub open_port {
    my $port     = shift;
    my $protocol = shift || 'TCP';
    my $cmd      = ['open-port', "$port/$protocol"];
    my $ret      = execute($cmd);
    return $ret->{stdout};
}

=func close_port(INT port, STR protocol)

Close port on service

=cut
sub close_port {
    my $port     = shift;
    my $protocol = shift || 'TCP';
    my $cmd      = ['close-port', "$port/$protocol"];
    my $ret      = execute($cmd);
    return $ret->{stdout};
}
1;
