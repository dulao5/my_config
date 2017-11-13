
timestr=$(date +"%Y%m%d.%H%M%S")
pre_log=/tmp/rspec.tw.$timestr.pre.log
test_log=/tmp/rspec.tw.$timestr.test.log

echo $pre_log
echo $test_log

echo $(date +"%Y%m%d.%H%M%S") > $pre_log
echo $(date +"%Y%m%d.%H%M%S") > $test_log

countries=("tw" "kr" "us")
for country in "${countries[@]}"
do
  export COUNTRY_CODE="${country}"
  echo $(date +"%Y%m%d.%H%M%S") COUNTRY_CODE:$COUNTRY_CODE >> $pre_log
  rbenv exec bundle exec rake config:generate >> $pre_log 2>&1
done

export COUNTRY_CODE="tw"

echo $(date +"%Y%m%d.%H%M%S") config:generate >> $pre_log
rbenv exec bundle exec rake config:generate >> $pre_log 2>&1


echo $(date +"%Y%m%d.%H%M%S") create_for_development and migrate >> $pre_log
RACK_ENV=development bundle exec rake db:create_for_development
RACK_ENV=development bundle exec padrino rake ar:migrate

echo $(date +"%Y%m%d.%H%M%S") db:create_for_test >> $pre_log
rbenv exec bundle exec parallel_rspec -n 7 -e "RACK_ENV=test bundle exec rake db:create_for_test" >> $pre_log 2>&1

echo $(date +"%Y%m%d.%H%M%S") ar:migrate >> $pre_log
rbenv exec bundle exec parallel_rspec -n 7 -e "RACK_ENV=test bundle exec padrino rake ar:migrate" >> $pre_log 2>&1

echo $(date +"%Y%m%d.%H%M%S") rspec test >> $pre_log
echo $(date +"%Y%m%d.%H%M%S") rspec test >> $test_log
RACK_ENV=test COVERAGE=1 rbenv exec bundle exec parallel_rspec -n 7 ./spec >> $test_log 2>&1
echo $(date +"%Y%m%d.%H%M%S") rspec test : end >> $pre_log
echo $(date +"%Y%m%d.%H%M%S") rspec test : end >> $test_log


# 並行testのように
# RACK_ENV=test COVERAGE=1 rbenv exec bundle exec parallel_rspec -n 7 spec/controllers/friend_controller_spec.rb
