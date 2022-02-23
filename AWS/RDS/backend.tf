terraform {
  backend "s3" {
    bucket = "pushbutton-yusuf"
    key    = "us/app/pushbutton/rds"
    region = "us-east-1"
  }
}


#pushbutton-yusuf