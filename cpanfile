requires "App::Cmd::Setup" => "0";
requires "Carp" => "0";
requires "IO::Prompter" => "0";
requires "Moo" => "0";
requires "Moo::Role" => "0";
requires "Path::Tiny" => "0";
requires "YAML::Tiny" => "0";
requires "namespace::clean" => "0";
requires "strict" => "0";
requires "warnings" => "0";

on 'test' => sub {
  requires "Mojolicious" => "0";
  requires "Test::Mojo" => "0";
  requires "Test::More" => "0";
  requires "Test::NoTabs" => "0";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

on 'develop' => sub {
  requires "Test::More" => "0";
  requires "Test::NoTabs" => "0";
};
