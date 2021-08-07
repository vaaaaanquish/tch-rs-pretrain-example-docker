// https://github.com/LaurentMazare/tch-rs/blob/master/examples/pretrained-models/main.rs

extern crate tch;
use anyhow::Result;
use tch::nn::ModuleT;
use tch::vision::{resnet, imagenet};


pub fn main() -> Result<()> {
    let image = imagenet::load_image_and_resize224("/app/img/example.jpeg")?;
    let weights = std::path::Path::new("/app/resnet18.ot"); 
    let mut vs = tch::nn::VarStore::new(tch::Device::Cpu);
    let net: Box<dyn ModuleT> = Box::new(resnet::resnet18(&vs.root(), imagenet::CLASS_COUNT));
    vs.load(weights)?;

    let output = net
        .forward_t(&image.unsqueeze(0), false)
        .softmax(-1, tch::Kind::Float);

    for (probability, class) in imagenet::top(&output, 5).iter() {
        println!("{:50} {:5.2}%", class, 100.0 * probability)
    }
    Ok(())
}

