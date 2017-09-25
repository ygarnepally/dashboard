provider "aws" {
  region = "${var.region}"
}

locals {
  instance_ids = <<EOF
   "type": "metric", "x": 0, "y": 24, "width": 24, "height": 6, "properties": { "view": "timeSeries", "metrics": [ [ "AWS/ECS", "MemoryUtilization", "ServiceName", "${var.ServiceName1}", "ClusterName", "${var.ClusterName}", { "stat": "SampleCount", "period": 30 } ], [ "...", "${var.ServiceName1}", ".", ".", { "stat": "SampleCount", "period": 30 } ] ], "region": "${var.region}", "title": "ECS- Containers", "period": 300, "stacked": false, "yAxis": { "left": { "min": 0 } } }
EOF
}

data "template_file" "example" {
  template =  <<EOF
      { "type": "metric", "x": 0, "y": 60, "width": 12, "height": 6, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "ReadIOPS", "DBInstanceIdentifier", "${var.DBInstanceIdentifier1}" ], [ ".", "WriteIOPS", ".", "." ] ], "region": "${var.region}", "title": "RDS>primary node-ReadIOPS, WriteIOPS " } },
      { "type": "metric", "x": 12, "y": 72, "width": 12, "height": 6, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "ReadLatency", "DBInstanceIdentifier", "${var.DBInstanceIdentifier1}" ], [ ".", "WriteLatency", ".", "." ] ], "region": "${var.region}", "title": "RDS>Primary-ReadLatency, WriteLatency" } },
      { "type": "metric", "x": 0, "y": 84, "width": 24, "height": 3, "properties": { "view": "singleValue", "metrics": [ [ "AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", "${var.DBInstanceIdentifier1}" ], [ ".", "SwapUsage", ".", "." ], [ ".", "CPUUtilization", ".", "." ], [ ".", "DiskQueueDepth", ".", "." ], [ ".", "FreeableMemory", ".", "." ], [ ".", "FreeStorageSpace", ".", "." ] ], "region": "${var.region}", "title": "RDS Metrics Primary" } },
      { "type": "metric", "x": 0, "y": 87, "width": 6, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", "${var.DBInstanceIdentifier1}" ] ], "region": "${var.region}" } },
      { "type": "metric", "x": 6, "y": 87, "width": 6, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "SwapUsage", "DBInstanceIdentifier", "${var.DBInstanceIdentifier1}", { "color": "#ff7f0e" } ] ], "region": "${var.region}" } }, 
      { "type": "metric", "x": 12, "y": 87, "width": 6, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", "${var.DBInstanceIdentifier1}", { "color": "#2ca02c" } ] ], "region": "${var.region}", "period": 300 } },
      { "type": "metric", "x": 18, "y": 87, "width": 6, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "DiskQueueDepth", "DBInstanceIdentifier", "${var.DBInstanceIdentifier1}", { "color": "#d62728" } ] ], "region": "${var.region}", "period": 300 } },
      { "type": "metric", "x": 0, "y": 90, "width": 12, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "FreeableMemory", "DBInstanceIdentifier", "${var.DBInstanceIdentifier1}", { "color": "#9467bd" } ] ], "region": "${var.region}" } },
      { "type": "metric", "x": 12, "y": 90, "width": 12, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "FreeStorageSpace", "DBInstanceIdentifier", "${var.DBInstanceIdentifier1}", { "color": "#8c564b" } ] ], "region": "${var.region}" } },
      { "type": "metric", "x": 12, "y": 60, "width": 12, "height": 6, "properties": { "view": "timeSeries", "stacked": false, "region": "${var.region}", "metrics": [ [ "AWS/RDS", "WriteThroughput", "DBInstanceIdentifier", "${var.DBInstanceIdentifier1}" ], [ ".", "ReadThroughput", ".", "." ] ], "title": "RDS-Primary ReadThroughput, WriteThroughput" } }
EOF
}

data "template_file" "example1" {
  template =  <<EOF
   { "type": "metric", "x": 0, "y": 96, "width": 6, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", "${var.DBInstanceIdentifier2}" ] ], "region": "${var.region}" } },
   { "type": "metric", "x": 0, "y": 66, "width": 12, "height": 6, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "ReadIOPS", "DBInstanceIdentifier", "${var.DBInstanceIdentifier2}" ], [ ".", "WriteIOPS", ".", "." ], [ ".", "ReadIOPS", ".", "${var.DBInstanceIdentifier2}" ], [ ".", "WriteIOPS", ".", "." ] ], "region": "${var.region}", "period": 300, "title": "RDS>Replica node-ReadIOPS, WriteIOPS" } },
   { "type": "metric", "x": 0, "y": 78, "width": 24, "height": 6, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "ReadLatency", "DBInstanceIdentifier", "${var.DBInstanceIdentifier2}" ], [ ".", "WriteLatency", ".", "." ], [ ".", "ReadLatency", ".", "${var.DBInstanceIdentifier2}" ], [ ".", "WriteLatency", ".", "." ] ], "region": "${var.region}", "title": "RDS>Replica-ReadLatency, WriteLatency" } },
   { "type": "metric", "x": 0, "y": 93, "width": 24, "height": 3, "properties": { "view": "singleValue", "metrics": [ [ "AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", "${var.DBInstanceIdentifier2}" ], [ ".", "SwapUsage", ".", "." ], [ ".", "CPUUtilization", ".", "." ], [ ".", "DiskQueueDepth", ".", "." ], [ ".", "FreeableMemory", ".", "." ], [ ".", "FreeStorageSpace", ".", "." ] ], "region": "${var.region}", "title": "RDS>Replica1 metrics", "period": 300 } },
   { "type": "metric", "x": 6, "y": 96, "width": 6, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "SwapUsage", "DBInstanceIdentifier", "${var.DBInstanceIdentifier2}", { "color": "#ff7f0e" } ] ], "region": "${var.region}" } },
   { "type": "metric", "x": 12, "y": 96, "width": 6, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", "${var.DBInstanceIdentifier2}", { "color": "#2ca02c" } ] ], "region": "${var.region}" } },
   { "type": "metric", "x": 18, "y": 96, "width": 6, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "DiskQueueDepth", "DBInstanceIdentifier", "${var.DBInstanceIdentifier2}", { "color": "#d62728" } ] ], "region": "${var.region}" } },
   { "type": "metric", "x": 12, "y": 99, "width": 12, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "FreeableMemory", "DBInstanceIdentifier", "${var.DBInstanceIdentifier2}", { "color": "#9467bd" } ] ], "region": "${var.region}" } },
   { "type": "metric", "x": 0, "y": 99, "width": 12, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "FreeStorageSpace", "DBInstanceIdentifier", "${var.DBInstanceIdentifier2}", { "color": "#8c564b" } ] ], "region": "${var.region}" } },
   { "type": "metric", "x": 12, "y": 66, "width": 12, "height": 6, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "ReadThroughput", "DBInstanceIdentifier", "${var.DBInstanceIdentifier2}" ], [ ".", "WriteThroughput", ".", "." ] ], "region": "${var.region}", "title": "RDS-Replica1-ReadThroughput, WriteThroughput" } }
EOF
}

data "template_file" "example2" {
  template =  <<EOF
   { "type": "metric", "x": 0, "y": 102, "width": 24, "height": 3, "properties": { "view": "singleValue", "metrics": [ [ "AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", "${var.DBInstanceIdentifier3}" ], [ ".", "SwapUsage", ".", "." ], [ ".", "CPUUtilization", ".", "." ], [ ".", "DiskQueueDepth", ".", "." ], [ ".", "FreeableMemory", ".", "." ], [ ".", "FreeStorageSpace", ".", "." ] ], "region": "${var.region}", "title": "RDS>Replica 2 Metrics", "period": 300 } },
   { "type": "metric", "x": 0, "y": 105, "width": 6, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "DatabaseConnections", "DBInstanceIdentifier", "${var.DBInstanceIdentifier3}" ] ], "region": "${var.region}" } },
   { "type": "metric", "x": 12, "y": 105, "width": 6, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "CPUUtilization", "DBInstanceIdentifier", "${var.DBInstanceIdentifier3}", { "color": "#2ca02c" } ] ], "region": "${var.region}" } },
   { "type": "metric", "x": 6, "y": 105, "width": 6, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "SwapUsage", "DBInstanceIdentifier", "${var.DBInstanceIdentifier3}", { "color": "#ff7f0e" } ] ], "region": "${var.region}", "period": 300 } },
   { "type": "metric", "x": 18, "y": 105, "width": 6, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "DiskQueueDepth", "DBInstanceIdentifier", "${var.DBInstanceIdentifier3}", { "color": "#d62728" } ] ], "region": "${var.region}" } },
   { "type": "metric", "x": 0, "y": 108, "width": 12, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "FreeableMemory", "DBInstanceIdentifier", "${var.DBInstanceIdentifier3}", { "color": "#9467bd" } ] ], "region": "${var.region}" } },
   { "type": "metric", "x": 12, "y": 108, "width": 12, "height": 3, "properties": { "view": "timeSeries", "stacked": false, "metrics": [ [ "AWS/RDS", "FreeStorageSpace", "DBInstanceIdentifier", "${var.DBInstanceIdentifier3}", { "color": "#8c564b" } ] ], "region": "${var.region}" } },
   { "type": "metric", "x": 0, "y": 72, "width": 12, "height": 6, "properties": { "view": "timeSeries", "stacked": false, "region": "${var.region}", "metrics": [ [ "AWS/RDS", "ReadThroughput", "DBInstanceIdentifier", "${var.DBInstanceIdentifier3}" ], [ ".", "WriteThroughput", ".", "." ] ], "title": "RDS-Replica2-ReadThroughput, WriteThroughput" } }   
EOF
}




locals {
  ids = "${list("${data.template_file.example.template}", "${data.template_file.example1.template}" )}"
}




#resource "aws_cloudwatch_dashboard" "main" {
#   dashboard_name = "${var.dashboard_name}"
#   count = "${length(var.DBInstanceIdentifier3) > 0 ? 1 : 0}"
#   dashboard_body = "{ \"widgets\": [ ${data.template_file.example.template} , ${data.template_file.example1.template}] }"
#}


data "template_file" "init" {
  template = "${file("temp.txt")}"
}



#resource "aws_cloudwatch_dashboard" "main" {
#   dashboard_name = "${var.dashboard_name}"
#   dashboard_body = "${data.template_file.init.template}"
#}
