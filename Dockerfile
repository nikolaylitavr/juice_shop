FROM mcr.microsoft.com/playwright:v1.49.1-noble

# 1. Prevent interactive installation prompts during build sequences
ENV DEBIAN_FRONTEND=noninteractive

# 2. Install Ruby 3.3 baseline system runtimes and native compilation utilities
RUN apt-get update && apt-get install -y \
    ruby-full \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 3. Establish your permanent working automation home directory
WORKDIR /workspace

# 4. Pre-bake core automation dependencies globally into the image layer
RUN gem install bundler rspec playwright-ruby-client

# 5. Pre-verify native browser driver dependencies for Playwright
RUN npx playwright install-deps chromium
