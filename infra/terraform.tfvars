aws_region = "us-east-1"
project_name = "ecs-threat-composer"
environment = "dev"

# Domain and SSL Configuration
domain_name = "ecs-project.ahmedmhcodelab.click" # The domain from your screenshot
subdomain = "tm"                                # Will create tm.ecs-project.ahmedmhcodelab.click
create_certificate = true
create_route53_record = true
hosted_zone_id = "Z0821158262GBIRNHQRH5"        # From your Route 53 screenshot

# create_certificate = false                    # Uncomment to disable HTTPS
# create_route53_record = false                 # Uncomment to disable DNS record creation