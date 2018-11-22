for $instancetype in //_
  let $price := $instancetype/price/USD/text()
  let $name := $instancetype/attributes/aws_003aec2_003ainstanceType
  let $instancegroup := substring-before($name,".")
  let $vcpu := $instancetype/attributes/aws_003aec2_003avcpu
  let $memory:= $instancetype/attributes/aws_003aec2_003amemory
  let $memgb := replace(substring-before($memory," "),",","")
  return concat($instancegroup,",",$name,",",$vcpu,",",$memgb,",",$price)