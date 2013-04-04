#!/usr/local/bin/morbo
use Mojolicious::Lite;
use Mojo::ByteStream 'b';
use Text::Markdown 'markdown';

get '/' => sub {
	my $self = shift;
	my $data_file = app->home->rel_file('markdown.txt');
	open my $fh, '<', $data_file;
	my $data = '';
	while (<$fh>) {
		$data .= b($_)->decode;
	}
	my $html = b(markdown($data))->html_unescape;
	$self->render(html => $html);
} => 'index';

app->start;

__DATA__
	
@@ index.html.ep
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	</head>
	<body>
		<title>Markdown</title>
		<%= $html %>
	</body>
</html>
