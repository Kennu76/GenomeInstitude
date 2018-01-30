defmodule Database.UploadController do  
    use Database.Web, :controller
    alias NimbleCSV
    alias Database.Data
    def upload_form(conn, _params) do
      render conn, "upload.html"
    end

    def store_it(row) do
        changeset = Data.changeset(%Data{}, row)
        Repo.insert!(changeset)
      end

    # This function is used when the parameters (a Map) have key "upload" in them, which has another Map
    # with the key "file" in them.
    def upload(conn, %{"upload" => %{"file" => file}}) do  
        
        # This loads the file into memory as a String
        {:ok, file_binary} = File.read(file.path)
        # This decodes the file from String into a list that consist of the rows of the file
        decoded = CSVLixir.parse(file_binary)
        # We do not need the first row of the file which is the header, we need everything after that so I split the list
        [head | tail] = decoded
        #IO.inspect MyParser.parse_string decoded
        
        File.stream!(file.path)
        |> CSV.decode(separator: ?;, headers: [:code,:idcode,:inst,:time,:first,:last,:email])
        |> Enum.each(&Database.UploadController.store_it/1)
       
        conn
        |> put_flash(:info, "File uploaded successfully!")
        |> render("upload.html")
    end
    # This function is used to upload the data, its given a list of the rows and works if the list is not empty
    def upload_data(conn, [h|t]) do
        # The tail of every element is an empty list that we do not need so I split it
        [hed|tal] = h
        # The row is split into different elements
        splitted = String.split(hed,";")
        #IO.inspect splitted |> Enum.at(0)
        # Here I upload the data into the local Repository
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
    # When the list of rows is empty aka when the upload process has finished then 
    # this function is used that just tells the user the upload was succesful
    def upload_data(conn, []) do
        IO.inspect "############### THE END ##################"
        IO.inspect DateTime.utc_now
        conn
        |> put_flash(:info, "Data uploaded successfully!")
        |> render("upload.html")
    end
  
    
  end  