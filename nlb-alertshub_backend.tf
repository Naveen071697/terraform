resource "aws_lb" "nlb_listing_backend" {
  name               = "nlb-listing-backend-${var.stage_name}"
  internal           = true
  load_balancer_type = "network"
  subnets            = [aws_subnet.sg_private_1.id, aws_subnet.sg_private_2.id]

  tags = {
    Environment = "nlb_listing_backend_${var.stage_name}"
  }
}

resource "aws_lb_listener" "nlb_listing_backend_listener" {
  load_balancer_arn = aws_lb.nlb_listing_backend.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_nlb_listing_backend.arn
  }
}
