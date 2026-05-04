
# 3
while true; do  aws-asg-activity | tail -4|column -t; sleep 1; echo; done

# 2
while true; do aws-elbv2-tg-health "arn:aws:elasticloadbalancing:us-east-2:375740441348:targetgroup/nlb-test-01-tg80/58a77fb083244380"; sleep 2 ; echo ; done

#1
while true; do aws-ec2-list|sort -k 9  | tail -4; sleep 2; echo; done

