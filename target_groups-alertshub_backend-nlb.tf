# API Gateway

resource "aws_lb_target_group" "tg_nlb_listing_backend" {
  name        = "tg-nlb-listing-backend-${var.stage_name}"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = aws_vpc.main_vpc.id
}

resource "aws_lb_target_group_attachment" "tg_nlb_listing_backend" {
  target_group_arn = aws_lb_target_group.tg_nlb_listing_backend.arn
  target_id        = element(aws_elastic_beanstalk_environment.pa_listing_backend.load_balancers, 0)
  port             = 80
}
