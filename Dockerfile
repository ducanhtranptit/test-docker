# Sử dụng node:alpine làm base image với phiên bản dành cho ARM64
FROM node:alpine AS build

# Đặt thư mục làm việc trong container
WORKDIR /app

# Sao chép tệp package.json và package-lock.json vào container
COPY package*.json ./

# Cài đặt các phụ thuộc
RUN npm install

# Sao chép mã nguồn của ứng dụng vào container
COPY . .

# Xây dựng ứng dụng React
RUN npm run build

# Sử dụng Nginx làm web server để phục vụ ứng dụng đã được xây dựng
FROM nginx:alpine

# Sao chép tệp cấu hình Nginx vào container
COPY nginx.conf /etc/nginx/nginx.conf

# Sao chép tệp build từ bước trước vào thư mục web của Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Mở cổng 80
EXPOSE 80

# Khởi động Nginx khi container được chạy
CMD ["nginx", "-g", "daemon off;"]
