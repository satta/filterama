name        = "Full Protein Domain Set"
author      = "Sascha Steinbiss"
version     = "1.1"
email       = "ss34@sanger.ac.uk"
short_descr = "Filters out candidates without full protein domain set"
description = "Filters out a candidate if it does not contain at " ..
              "least one match for each RT, PR, INT and RH."

function classify_name(name)
  if string.find(name, "AP_") or name == 'RVP' then
    return "PR"
  elseif string.find(name, "ENV_") then
    return "ENV"
  elseif string.find(name, "GAG") then
    return "GAG"
  elseif string.find(name, "INT_") then
    return "INT"
  elseif string.find(name, "RNaseH")
    or name == 'rve'
    or string.find(name, "Integrase") then
    return "RH"
  elseif string.find(name, "RT_")
    or name == 'RVT_1'
    or name == 'RVT_2'
    or name == 'RVT_thumb' then
    return "RT"
  end
end

function filter(gn)
  local present = {}
  gfi = gt.feature_node_iterator_new(gn)
  node = gfi:next()
  while not (node == nil) do
    if (node:get_type() == "protein_match") then
      domain = node:get_attribute("name")
      if not (classify_name(domain) == nil) then
        present[classify_name(domain)] = true
      end
    end
    node = gfi:next()
  end
  if present.RT and present.PR and present.INT and present.RH then
    return false
  end
  return true
end
