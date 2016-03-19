FROM scorpil/rust:1.7
WORKDIR /app
ADD Cargo.toml /app/Cargo.toml
RUN mkdir src && echo "fn main() {}" > src/main.rs
RUN cargo build
ADD . /app
RUN cargo build
CMD ./target/debug/hello_world