$dvi_previewer = "zathura";
$pdf_previewer = "zathura";
$ps_previewer = "zathura";

# Add template folder to the search path
$ENV{'TEXINPUTS'} = '' unless defined $ENV{'TEXINPUTS'};
$ENV{'TEXINPUTS'} = $ENV{'TEXINPUTS'} . $search_path_separator . './template/';

$latex = 'pdflatex -shell-escape';
$pdflatex = 'pdflatex -synctex=1 -shell-escape';
@generated_exts = (@generated_exts, 'synctex.gz');

$clean_ext = "bbl nav out snm";

my $pplatex_exe = 'pplatex';
$pplatex_output = `$pplatex_exe -V`;
if ($? == 0) {
    $failure_cmd = $pplatex_exe . ' -q -i "%R.log"';
    $latex .= ' -interaction=nonstopmode';
    $pdflatex .= ' -interaction=nonstopmode';
}
