require 'json'

class ::Hash
    def deep_merge(second)
        merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
        self.merge(second, &merger)
    end
end

class JsonRehasher
    def normalize(input_hash, value_hash)
        keys = input_hash.split(".").reverse
        output_hash = keys.reduce({}) { |acc, next_key|
            first_key = acc.keys[0]
            last_key = keys[keys.length-1]

            if next_key != nil
                if first_key != nil
                    if next_key == last_key # at the last outer key)
                        acc = {next_key => acc}
                    else # have inserted into acc and now on next embedded key
                        acc = {next_key => acc}
                    end
                else # brand new
                    acc[next_key] = value_hash
                end
            end
            acc
        }

        return output_hash
    end

    # inplace could be replaced with tail rec
    def re_hash(input_hash)
        input_hash.keys.each { |k|

            value_hash = input_hash[k]
            if value_hash != nil and value_hash.is_a? Hash and value_hash.keys.length > 0
                value_hash = re_hash(value_hash)
            end

            if k.index('.') != nil
                input_hash.delete(k)
                normalized_hash = normalize(k, value_hash)
                input_hash = input_hash.deep_merge(normalized_hash)
            else
                input_hash.delete(k)
                input_hash = input_hash.merge({k => value_hash})
            end
        }
        return input_hash
    end

    def processFile(input_file)
        if input_file == nil
            puts "processFile() input was nil!"
            return nil
        end

        begin
            debug = false
            file = File.read(input_file)
            data_hash = JSON.parse(file)
            data_hash = processHash(data_hash)
            return data_hash.to_json()
        rescue SystemCallError
            puts "Could not find file \"#{input_file}\". Ensure that this file exists and try again."
            return nil
        rescue => ex
            puts "Unknown error occured. Please contact the admin or maintainer of jsonrehasher. Error: #{ex.backtrace}"
            return nil
        end
    end

    def process(input_string)
        if input_string == nil
            puts "process() input was nil!"
            return nil
        end

        begin
            data_hash = JSON.parse(input_string)
            data_hash = re_hash(data_hash)
            return data_hash.to_json()
        rescue => ex
            puts "Unknown error occured during process(). Please contact the admin or maintainer of jsonrehasher. Error: #{ex.backtrace}. Tried: #{input_string}"
            return nil
        end
    end

    def processHash(input_hash)
        if input_hash == nil
            puts "processHash() input was nil!"
            return nil
        end

        begin
            data_hash = re_hash(input_hash)
            return data_hash
        rescue => ex
            puts "Unknown error occured during processHash(). Please contact the admin or maintainer of jsonrehasher. Error: #{ex.backtrace}. Tried: #{input_hash}."
            return nil
        end
    end
end
