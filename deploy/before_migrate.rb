run "cd #{release_path} && bundle install"

run "cd #{release_path} && CAPTA_GEMPATH=`bundle show curb`"

capta_gempath_warning = "Deployment aborted: the gem capta is probably pointing to the vendor application folder " +
                        "when it should be pointing to the git repository. Check your Gemfile and retry."

run "/usr/bin/env ruby -e \"capta_gempath = '`echo $CAPTA_GEMPATH`' ; raise '#{capta_gempath_warning}' if capta_gempath =~ /curb/ \""