package com.ces.androidappkit.ui.home.adapter

import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.AsyncListDiffer
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.RecyclerView
import com.ces.androidappkit.databinding.ItemProductsBinding
import com.ces.androidappkit.ui.home.model.ModelProduct

//Using Async List Differ
class AdapterProduct() : RecyclerView.Adapter<AdapterProduct.ViewHolder>() {

    var onItemClick: ((ModelProduct) -> Unit)? = null
    var onFavouriteClick: ((ModelProduct) -> Unit)? = null

    inner class ViewHolder(val binding: ItemProductsBinding) :
        RecyclerView.ViewHolder(binding.root) {
        init {
            binding.ivHeart.setOnClickListener {
                onFavouriteClick?.invoke(differ.currentList[adapterPosition])
            }
            binding.root.setOnClickListener {
                onItemClick?.invoke(differ.currentList[adapterPosition])
            }
        }
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = ItemProductsBinding.inflate(LayoutInflater.from(parent.context))
        return ViewHolder(view)
    }

    fun submitList(data: List<ModelProduct?>) {
        differ.submitList(data)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.binding.model = differ.currentList[position]
    }

    override fun getItemCount(): Int {
        return differ.currentList.size
    }

    private val differCallback = object : DiffUtil.ItemCallback<ModelProduct>() {
        override fun areItemsTheSame(
            oldItem: ModelProduct,
            newItem: ModelProduct
        ): Boolean {
            return oldItem.id == newItem.id
        }

        override fun areContentsTheSame(
            oldItem: ModelProduct,
            newItem: ModelProduct
        ): Boolean {
            return oldItem == newItem
        }
    }

    private val differ = AsyncListDiffer(this, differCallback)

}