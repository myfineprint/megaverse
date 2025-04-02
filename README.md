## 🛠️ Setup

### 1️⃣ Install Dependencies
Ensure you have **Ruby (>= 3.0)** installed. Then, install required gems:

```sh
bundle install
```

### 2️⃣ Configure Environment Variables
Create a `.env` file based on `.env.example` and set your environment variables:

```sh
cp .env.example .env
```

Edit the `.env` file and replace placeholders with your actual values.

### 3️⃣ Run the Script
To generate the logo:

```sh
ruby lib/draw_logo.rb
```

### 4️⃣ Run Tests
The test suite is built using **RSpec**. Run:

```sh
bundle exec rspec
```

## 🛠️ Environment Variables
- **`BASE_URL`**: The API base URL.
- **`CANDIDATE_ID`**: The candidate's unique ID used for API requests.

## 🧪 Testing
The test suite uses:
- **RSpec** for unit tests.
- **Mocks** to simulate API calls.

To run tests, execute:

```sh
bundle exec rspec
```

To run a specific test file, run:

```sh
bundle exec rspec 'relative path of file'
```


## 🗂️ Project Structure
```
├── lib/
│   ├── draw_cross.rb          # Main logic for rendering the cross
│   ├── draw_logo.rb           # Main logic for rendering the logo
│   ├── services/
│   │   ├── megaverse.rb       # Handles map retrieval
│   │   ├── editors/
│   │   │   ├── cometh_editor.rb
│   │   │   ├── megaverse_editor.rb
│   │   │   ├── polyanet_editor.rb
│   │   │   ├── soloon_editor.rb
├── spec/                      # Test suite
│   │── lib/
│   │   ├── draw_cross_spec.rb
│   │   ├── draw_logo_spec.rb
│   │   ├── services/
│   │   │   ├── megaverse_spec.rb
│   │   │   ├── editors/
│   │   │   │   ├── cometh_editor_spec.rb
│   │   │   │   ├── megaverse_editor_spec.rb
│   │   │   │   ├── polyanet_editor_spec.rb
│   │   │   │   ├── soloon_editor_spec.rb
│   ├── spec_helper.rb
├── .env.example               # Sample environment variables
├── README.md                  # Documentation
```

---

