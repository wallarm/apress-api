json.status @status

json.errors do
  json.array! @errors do |error|
    error.each do |k, v|
      if k.respond_to?(:attribute)
        json.set! k.attribute, k.type
      else
        json.set! k, v
      end
    end
  end
end
