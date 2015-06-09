#!/usr/bin/perl -w

use English;
use strict;
use IO::Socket;


# Open socket
my $socket = new IO::Socket::INET (
    LocalPort => 8004,
    Listen    => 1,
    Proto     => 'tcp',
    Reuse     => 1
) || die "$!\n";


print "listener started...\n\n";

while(  )
{
	my( $client, $client_addr ) = $socket->accept();

    $client->recv(my $response, 32);
	chomp $response;
	print "Client query from\n";
#	$client->send("connected\n");

	if ($response eq 'uptime')
	{
		my $uptime = `uptime`;
		$client->send("$uptime\n");
		print "Uptime: $uptime\n";
	}
	if ($response eq 'halt')
	{
		system("halt");
		$client->send("System going down\n");
		print "System going down\n";
	}
	if ($response eq 'reboot')
	{
		system("reboot")
		$client->send("System is rebooting\n");
		print "System is rebooting\n";
	}
   # close $client;

}
close $socket;
