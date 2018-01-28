defmodule Database.UploadController do  
    use Database.Web, :controller

    alias Database.Data
    def upload_form(conn, _params) do
        
      render conn, "upload.html"
    end

    def upload_data(conn, []) do
        conn
        |> put_flash(:info, "Data uploaded successfully!")
        |> render("upload.html")
    end

    def upload_data(conn, [h|t]) do
        [hed|tal] = h
        splitted = String.split(hed,";")
        IO.inspect splitted |> Enum.at(0)
        %Database.Data{
            code: splitted |> Enum.at(0),
            idcode: splitted |> Enum.at(1),
            inst:  splitted |> Enum.at(2),
            time:  splitted |> Enum.at(3),
            first:  splitted |> Enum.at(4),
            last:  splitted |> Enum.at(5),
            email:  splitted |> Enum.at(6)}
        |> Database.Repo.insert!
        upload_data(conn, t)
    end
  
    def upload(conn, %{"upload" => %{"file" => file}}) do  
        # Get the file's extension
        file_extension = Path.extname(file.filename)
        IO.inspect "####################################"
        # Generate the UUID
        #file_uuid = UUID.uuid4(:hex)
        18:36:13.78
        18:36:13
        
        IO.inspect "####################################"
        # Load the file into memory
        {:ok, file_binary} = File.read(file.path)
        #IO.inspect file_binary
        decoded = CSVLixir.parse(file_binary)
        #IO.inspect decoded
        [head | tail] = decoded
        IO.inspect DateTime.utc_now
        upload_data(conn,tail)
        IO.inspect DateTime.utc_now
        conn
        |> put_flash(:success, "File uploaded successfully!")
        |> render("upload.html")
    end
  end  